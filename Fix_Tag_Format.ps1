# Hugo 标签格式紧急修复工具
# 功能：修复 "tags:" 下面多余的 "- tags:" 嵌套错误

Write-Host "=== Hugo 标签格式修复工具 ===" -ForegroundColor Cyan
Write-Host "正在扫描并修复格式错误..." -ForegroundColor Gray
Write-Host ""

$targetDir = "content"
$count = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 检查是否存在错误的嵌套格式
    # 匹配模式：tags: (换行) (空格) - tags:
    if ($content -match "tags:\s*[\r\n]+\s*-\s*tags:") {
        
        # 使用正则替换，将 "tags:\n  - tags:" 替换为 "tags:"
        # 这样下面的 "- 消息队列" 就会自动接上来，格式就对了
        $newContent = $content -replace "tags:\s*[\r\n]+\s*-\s*tags:", "tags:"
        
        $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
        
        Write-Host "🔧 已修复: $($file.Name)" -ForegroundColor Green
        $count++
    }
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "共修复文件: $count 个" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan