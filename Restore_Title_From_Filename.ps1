# Hugo 标题紧急恢复工具
# 功能：将文章的 title 字段强制重置为文件名 (BaseName)
# 用于修复被错误脚本覆盖标题的情况

Write-Host "=== Hugo 标题恢复工具 ===" -ForegroundColor Cyan
Write-Host "正在利用文件名恢复标题..." -ForegroundColor Gray

$targetDir = "content"
$count = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    # 跳过 _index.md
    if ($file.Name -like "_index*") { return }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $fileNameNoExt = $file.BaseName # 获取不带后缀的文件名，例如 "消息队列如何保证消息的有效性"
    
    # 检查当前的 title 是否坏掉了 (包含 "tags:" 或者看起来很短且不对劲)
    # 或者为了彻底修复，我们直接无条件把 title 修正为文件名（推荐）
    
    # 正则匹配 title 行
    if ($content -match '(?m)^title:\s*".*?"') {
        $oldTitleLine = $matches[0]
        
        # 构造正确的 title 行
        $newTitleLine = "title: `"$fileNameNoExt`""
        
        # 只有当标题不一致时才修复
        if ($oldTitleLine -ne $newTitleLine) {
            # 替换
            $newContent = $content -replace '(?m)^title:\s*".*?"', $newTitleLine
            $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
            
            Write-Host "✅ 已恢复: $($file.Name)" -ForegroundColor Green
            Write-Host "   旧: $oldTitleLine" -ForegroundColor Gray
            Write-Host "   新: $newTitleLine" -ForegroundColor Yellow
            $count++
        }
    }
}

Write-Host ""
Write-Host "=== 恢复完成，共修复 $count 篇文章 ===" -ForegroundColor Cyan