# Hugo 标签修复工具 V3 (修复标题断裂 + 强制标签清洗)
# 1. 修复之前脚本误伤标题的问题
# 2. 强制执行：八股->Java/MQ，AI->大模型

Write-Host "=== Hugo 标签修复工具 V3 ===" -ForegroundColor Cyan
Write-Host "正在扫描并修复格式..." -ForegroundColor Gray

$targetDir = "content"
$count = 0
$fixedCount = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    # 跳过 _index.md
    if ($file.Name -like "_index*") { return }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $needsSave = $false
    
    # ==========================================
    # 1. 紧急修复：被截断的标题
    # ==========================================
    # 检测模式：title: "xxx tags: (换行) - Java
    if ($content -match '(?m)^title: "(.*?)tags:\s*[\r\n]+\s*-\s*([A-Za-z0-9\u4e00-\u9fa5]+)') {
        # 修复逻辑：把换行和横杠去掉，拼回去
        # 比如把 title: "说一说tags:\n - Java" 变成 title: "说一说tags: Java"
        $content = $content -replace '(?m)^title: "(.*?)tags:\s*[\r\n]+\s*-\s*([A-Za-z0-9\u4e00-\u9fa5]+)', 'title: "$1tags: $2'
        $needsSave = $true
        Write-Host "🚑 [急救] 修复了断裂的标题: $($file.Name)" -ForegroundColor Red
    }

    # ==========================================
    # 2. 标签强制清洗逻辑
    # ==========================================
    
    # 提取 Front Matter
    if ($content -match '(?s)^---(.*?)---') {
        $fm = $matches[1]
    } else { return }

    # 判断分类
    $isBagu = $fm -match 'categories:[\s\S]*?-\s*"?八股"?'
    $isAI   = $fm -match 'categories:[\s\S]*?-\s*"?AI"?'

    if ($isBagu -or $isAI) {
        $targetTag = $null
        
        # 检查整个 FM 是否包含关键字
        if ($isAI -and $fm -match "大模型") {
            $targetTag = "大模型"
        }
        elseif ($isBagu) {
            if ($fm -match "消息队列" -or $fm -match "Kafka" -or $fm -match "RabbitMQ") {
                $targetTag = "消息队列"
            }
            elseif ($fm -match "Java") {
                $targetTag = "Java"
            }
        }

        # 如果确定了目标标签，强制替换整个 tags 块
        if ($targetTag) {
            # 正则：匹配 ^tags: 开始，直到遇到下一个字段（如 draft: 或 ---）
            # (?m) 开启多行模式，^tags: 确保匹配行首，不会匹配到 title 里的 tags
            $pattern = '(?m)^tags:\s*(\[.*?\]|[\s\S]*?(?=(\n\w+:)|$))'
            
            $newTagBlock = "tags:`n  - $targetTag"

            if ($content -match $pattern) {
                $oldBlock = $matches[0]
                # 只有当不一样时才替换
                if ($oldBlock.Trim() -ne $newTagBlock.Trim()) {
                    # 使用 Regex Replace 确保只替换 Front Matter 里的那个 tags
                    # 这里的逻辑是：先把 content 分成 FM 和 Body，只改 FM
                    $parts = $content -split '---', 3
                    if ($parts.Count -ge 3) {
                        # parts[1] 是 Front Matter
                        if ($parts[1] -match $pattern) {
                            $parts[1] = $parts[1] -replace $pattern, $newTagBlock
                            $content = "---" + $parts[1] + "---" + $parts[2]
                            $needsSave = $true
                        }
                    }
                }
            } else {
                # 如果没找到 tags: (且不是标题里的)，则追加
                # 避免重复追加，先简单粗暴处理：直接插在 draft: 前面或者 categories: 后面
                if (-not ($content -match '(?m)^tags:')) {
                   $content = $content -replace '(?m)^(categories:[\s\S]*?)(?=\n[a-z])', "$1`n$newTagBlock"
                   $needsSave = $true
                }
            }
            
            if ($needsSave) {
                 Write-Host "✅ [清洗] $($file.Name) -> $targetTag" -ForegroundColor Green
                 $fixedCount++
            }
        }
    }

    if ($needsSave) {
        $content | Set-Content $file.FullName -Encoding UTF8 -NoNewline
    }
    $count++
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "共修复/清洗: $fixedCount 篇" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan