Clean_Tags_Specific.ps1# Hugo 特定标签清洗脚本
# 功能：
# 1. 八股 + 包含"消息队列" -> 标签改为 ["消息队列"]
# 2. 八股 + 包含"Java"     -> 标签改为 ["Java"]
# 3. AI   + 包含"大模型"   -> 标签改为 ["大模型"]

Write-Host "=== Hugo 特定标签清洗工具 ===" -ForegroundColor Cyan
Write-Host "正在扫描并执行特定清洗规则..." -ForegroundColor Gray
Write-Host ""

$targetDir = "content"
$count = 0
$modifiedCount = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    # 跳过 _index.md
    if ($file.Name -like "_index*") { return }
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. 提取 YAML Front Matter
    if ($content -match '(?s)^---(.*?)---') {
        $fm = $matches[1]
    } else {
        return # 不是 YAML 格式跳过
    }

    # 2. 提取分类 (Categories) 和 标签 (Tags) 的原始文本块
    $hasCategoryBagu = $fm -match 'categories:[\s\S]*?-\s*"?八股"?'
    $hasCategoryAI   = $fm -match 'categories:[\s\S]*?-\s*"?AI"?'
    
    # 如果既不是八股也不是AI，直接跳过，节省时间
    if (-not ($hasCategoryBagu -or $hasCategoryAI)) { return }

    # 提取 tags 块的内容
    $tagsPattern = 'tags:\s*(\[.*?\]|[\s\S]*?(?=(\n\w+:)|$))'
    $currentTagsRaw = ""
    if ($fm -match $tagsPattern) {
        $currentTagsRaw = $matches[1] # 获取 tags: 后面的内容
    } else {
        return # 没有标签的不处理
    }

    # 3. 核心判断逻辑
    $finalTag = $null
    
    # === 规则 1 & 2: 分类是 "八股" ===
    if ($hasCategoryBagu) {
        if ($currentTagsRaw -match "消息队列") {
            $finalTag = "消息队列"
        }
        elseif ($currentTagsRaw -match "Java") {
            $finalTag = "Java"
        }
    }
    
    # === 规则 3: 分类是 "AI" ===
    if ($hasCategoryAI) {
        if ($currentTagsRaw -match "大模型") {
            $finalTag = "大模型"
        }
    }

    # 4. 执行修改
    # 只有当计算出了新标签，且新标签与原标签内容不一致时才修改
    if ($finalTag) {
        # 检查是否已经是这个标签了 (避免重复修改)
        # 我们简单检查一下：如果原始tags里包含新标签，且长度很短(说明只有一个)，就不改
        # 但为了保险，还是强制重写一遍最稳妥

        $newTagsBlock = "tags:`n  - $finalTag"
        
        # 替换 Front Matter 中的 tags 部分
        $oldTagsBlockFull = $matches[0] # 包含 "tags:" 的完整匹配
        
        # 只有当原文本和新文本不一样时才写文件
        # (这里做一个简单的字符串包含检查，防止已经清洗过的文件被反复报告)
        # 如果原tags里有多余字符(比如列表项多于1个)，肯定不相等
        
        # 构建新的 Front Matter
        $newFm = $fm.Replace($oldTagsBlockFull.TrimEnd(), $newTagsBlock)
        
        # 如果新旧 FM 不一样，说明需要修改
        if ($newFm -ne $fm) {
            $newContent = "---$newFm---" + ($content -replace '(?s)^---.*?---', '')
            $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
            
            Write-Host "✅ [修正] $($file.Name)" -ForegroundColor Green
            Write-Host "   分类: $(if($hasCategoryBagu){'八股'}else{'AI'})" -ForegroundColor Gray
            Write-Host "   结果: $finalTag" -ForegroundColor Yellow
            $modifiedCount++
        }
    }

    $count++
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "扫描文件: $count"
Write-Host "修改文章: $modifiedCount" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan