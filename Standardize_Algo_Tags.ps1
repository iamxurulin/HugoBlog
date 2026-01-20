# Hugo 算法文章标签强制标准化工具
# 功能：
# 1. 只处理 categories 包含 "算法" 的文章
# 2. 标签强制变为单标签
# 3. 标签只能是：数组、链表、搜索、动态规划、二叉树、位运算、HashMap、栈与队列、堆

Write-Host "=== Hugo 算法标签标准化工具 ===" -ForegroundColor Cyan
Write-Host "正在扫描并清洗标签..." -ForegroundColor Gray
Write-Host ""

# ================== 1. 定义白名单和关键词映射 ==================
# 优先级：越靠前越优先匹配
$tagRules = @(
    @{ Name = "二叉树";   Keywords = @("二叉树", "Tree", "BST", "前序", "中序", "后序", "左子树", "右子树") },
    @{ Name = "链表";     Keywords = @("链表", "Linked List", "ListNode", "双向链表") },
    @{ Name = "搜索";     Keywords = @("搜索", "DFS", "BFS", "回溯", "深度优先", "广度优先", "全排列", "岛屿", "递归") },
    @{ Name = "动态规划"; Keywords = @("动态规划", "DP", "背包", "状态转移", "打家劫舍", "股票", "子序列") },
    @{ Name = "堆";       Keywords = @("堆", "Heap", "大顶堆", "小顶堆", "优先队列", "PriorityQueue", "第K大") },
    @{ Name = "栈与队列"; Keywords = @("栈", "Stack", "队列", "Queue", "括号", "单调栈", "单调队列") },
    @{ Name = "位运算";   Keywords = @("位运算", "Bit", "异或", "二进制", "补码", "只出现一次") },
    @{ Name = "HashMap";  Keywords = @("HashMap", "哈希", "Hash", "Map", "两数之和", "计数") },
    @{ Name = "数组";     Keywords = @("数组", "Array", "双指针", "滑动窗口", "二分", "前缀和", "矩阵", "排序") } 
)

# 允许的标签列表 (用于快速查找)
$allowedTags = $tagRules.Name

# =============================================================

$targetDir = "content"
$count = 0
$modifiedCount = 0

Get-ChildItem -Path $targetDir -Filter "*.md" -Recurse | ForEach-Object {
    $file = $_
    # 跳过 _index.md
    if ($file.Name -like "_index*") { return }
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. 解析 Front Matter
    $isYaml = $content -match '(?s)^---(.*?)---'
    if (-not $isYaml) { return } # 这里主要处理 YAML，因为你的是 YAML 格式
    $fm = $matches[1]

    # 2. 检查分类是否包含 "算法"
    # 简单的正则匹配 categories 部分
    if (-not ($fm -match 'categories:[\s\S]*?-\s*"?算法"?')) {
        # 如果不是算法文章，直接跳过
        return
    }

    # 3. 提取现有标签
    $currentTags = @()
    if ($fm -match 'tags:\s*(\[.*?\]|[\s\S]*?(?=(\n\w+:)|$))') {
        $rawTags = $matches[1]
        $currentTags = $rawTags.Split(",`n`r[]-") | ForEach-Object { $_.Trim().Trim("'").Trim('"') } | Where-Object { $_ -ne "" }
    }

    # 4. 核心逻辑：决定最终标签
    $finalTag = $null

    # 策略 A: 如果现有标签里已经包含了白名单里的词，直接用它
    foreach ($t in $currentTags) {
        if ($allowedTags -contains $t) {
            $finalTag = $t
            break # 只要找到一个合法的，就用它，不再找了（满足“只要一个”）
        }
    }

    # 策略 B: 如果现有标签都不在白名单里，通过标题和正文关键词推断
    if ([string]::IsNullOrEmpty($finalTag)) {
        $fullText = $content # 标题+正文
        
        foreach ($rule in $tagRules) {
            foreach ($kw in $rule.Keywords) {
                if ($fullText -match "(?i)$kw") {
                    $finalTag = $rule.Name
                    break
                }
            }
            if ($finalTag) { break }
        }
    }

    # 策略 C: 实在匹配不到，默认归为 "数组" (作为基础兜底)
    if ([string]::IsNullOrEmpty($finalTag)) {
        $finalTag = "数组"
    }

    # 5. 更新文件 (只有当标签需要改变时才写文件)
    # 构建新的 tags 块
    $newTagsBlock = "tags:`n  - $finalTag"
    
    # 获取旧的 tags 块字符串
    $pattern = 'tags:\s*(\[.*?\]|[\s\S]*?(?=(\n\w+:)|$))'
    if ($fm -match $pattern) {
        $oldTagsBlock = $matches[0]
        
        # 简单比对：如果新生成的标签字符串和原来的不一样，就替换
        # 注意：这里我们做个简化判断，避免反复写入
        # 如果原标签已经是单一的且正确的，就不改
        $isClean = ($currentTags.Count -eq 1) -and ($currentTags[0] -eq $finalTag)
        
        if (-not $isClean) {
            # 替换 Front Matter
            $newFm = $fm.Replace($oldTagsBlock.TrimEnd(), $newTagsBlock)
            $newContent = "---$newFm---" + ($content -replace '(?s)^---.*?---', '')
            
            $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
            
            Write-Host "✅ [修正] $($file.Name)" -ForegroundColor Green
            Write-Host "   原标签: $($currentTags -join ', ')" -ForegroundColor Gray
            Write-Host "   新标签: $finalTag" -ForegroundColor Yellow
            $modifiedCount++
        }
    } else {
        # 如果原来没标签，插入标签
        $newFm = $fm + "`n$newTagsBlock"
        $newContent = "---$newFm---" + ($content -replace '(?s)^---.*?---', '')
        $newContent | Set-Content $file.FullName -Encoding UTF8 -NoNewline
        Write-Host "✅ [新增] $($file.Name) -> $finalTag" -ForegroundColor Cyan
        $modifiedCount++
    }
    
    $count++
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "共处理算法文章: $count 篇"
Write-Host "实际修改: $modifiedCount 篇" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan