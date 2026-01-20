# Hugo 标题强制重置工具
# 功能：不管 title 现在是什么乱七八糟的内容，统统改成文件名
# 修复：title: "tags: xxx" 这种错误

Write-Host "=== Hugo 标题强制重置工具 ===" -ForegroundColor Cyan
Write-Host "正在把文件名写入标题字段..." -ForegroundColor Gray

$targetDir = "content"
$count = 0

if (!(Test-Path $targetDir)) {
    Write-Host "错误：找不到 content 目录" -ForegroundColor Red
    exit
}

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    # 跳过 _index.md
    if ($file.Name -like "_index*") { return }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 获取文件名（不带后缀），这现在是你唯一正确的元数据
    $correctTitle = $file.BaseName
    
    # 构造正确的标题行
    $newTitleLine = "title: `"$correctTitle`""
    
    # 正则逻辑：
    # (?m) 开启多行模式
    # ^title:.*$ 匹配以 title: 开头的一整行内容
    if ($content -match '(?m)^title:.*$') {
        $currentTitleLine = $matches[0]
        
        # 只有当现在的标题行 不等于 我们想要的标题行时，才修改
        if ($currentTitleLine -ne $newTitleLine) {
            
            # 强制替换整行
            $newContent = $content -replace '(?m)^title:.*$', $newTitleLine
            
            $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
            
            Write-Host "✅ [修复] $($file.Name)" -ForegroundColor Green
            Write-Host "   旧: $currentTitleLine" -ForegroundColor Gray
            Write-Host "   新: $newTitleLine" -ForegroundColor Yellow
            $count++
        }
    }
}

Write-Host ""
Write-Host "=== 修复完成，共重置 $count 篇文章的标题 ===" -ForegroundColor Cyan