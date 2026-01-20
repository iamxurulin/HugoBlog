# Hugo 安全标签清洗工具 (绝对不碰标题版)

Write-Host "=== Hugo 安全标签清洗工具 ===" -ForegroundColor Cyan

$targetDir = "content"
$count = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    if ($file.Name -like "_index*") { return }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. 获取 Front Matter (--- ... ---)
    if ($content -match '(?s)^---(.*?)---') {
        $fm = $matches[1]
    } else { return }

    # 2. 判断分类
    $isBagu = $fm -match 'categories:[\s\S]*?-\s*"?八股"?'
    $isAI   = $fm -match 'categories:[\s\S]*?-\s*"?AI"?'

    if (-not ($isBagu -or $isAI)) { return }

    # 3. 决定目标标签
    $targetTag = $null
    
    # 检查全文内容来决定标签 (比只检查FM更全，但写入时只写FM)
    if ($isAI -and $content -match "大模型") {
        $targetTag = "大模型"
    }
    elseif ($isBagu) {
        if ($content -match "消息队列" -or $content -match "Kafka" -or $content -match "RabbitMQ") {
            $targetTag = "消息队列"
        }
        elseif ($content -match "Java") {
            $targetTag = "Java"
        }
    }

    # 4. 执行替换 (只针对 tags 区域)
    if ($targetTag) {
        $newTagsBlock = "tags:`n  - $targetTag"
        
        # 寻找旧的 tags 块
        # 正则解释：
        # (?m) 多行模式
        # ^tags: 匹配行首的 tags: (这保证了绝对不会匹配到 title 里的 tags)
        # ([\s\S]*?) 非贪婪匹配后续内容
        # (?=^draft:|^categories:|^date:|---) 直到遇到下一个常见的 yaml 键或者结束符
        $pattern = '(?m)^tags:[\s\S]*?(?=(^draft:|^categories:|^date:|---))'
        
        if ($content -match $pattern) {
            $oldBlock = $matches[0]
            
            # 简单对比：去空格后是否一样
            if ($oldBlock -replace "\s","" -ne $newTagsBlock -replace "\s","") {
                # 执行替换
                $content = $content -replace $pattern, $newTagsBlock
                $content | Set-Content $file.FullName -Encoding UTF8 -NoNewline
                Write-Host "✅ [清洗] $($file.Name) -> $targetTag" -ForegroundColor Green
                $count++
            }
        }
    }
}
Write-Host "=== 清洗完成，修改了 $count 篇 ===" -ForegroundColor Cyan