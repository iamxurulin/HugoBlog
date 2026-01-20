# Hugo 查找未分类文章工具

Write-Host "=== 正在查找没有分类 (categories) 的文章 ===" -ForegroundColor Cyan

# 设置目录
$targetDir = "content"

$count = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 排除 _index.md (这些是分类/标签的封面配置文件，本来就不需要分类)
    if ($file.Name -like "_index*.md") { return }

    # 检查是否包含 categories
    # 兼容 TOML (categories =) 和 YAML (categories:)
    if (-not ($content -match "categories\s*[=:]")) {
        Write-Host "⚠️ 发现无分类文章: " -NoNewline -ForegroundColor Yellow
        Write-Host $file.FullName.Replace((Get-Location).Path, "") -ForegroundColor White
        $count++
    }
}

Write-Host ""
Write-Host "------------------------------------------------" -ForegroundColor Gray
Write-Host "共发现 $count 个文件没有分类。" -ForegroundColor Green
Write-Host "请检查这些文件，如果是普通文章，请手动添加 categories。" -ForegroundColor Yellow
Write-Host "如果是 page/about 等系统页面，请忽略。" -ForegroundColor Gray
Write-Host "------------------------------------------------" -ForegroundColor Gray