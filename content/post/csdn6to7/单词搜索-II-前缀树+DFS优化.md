---
title: "单词搜索-II-前缀树+DFS优化"
date: 2025-11-22 22:17:00
categories:
- 算法
tags:
  - 二叉树
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/c09ec444aeb24eec8767d9c2304f1297.png#pic_center)
### 求解思路
首先将所有目标单词构建成一棵前缀树，然后遍历网格中的每个位置作为起点进行DFS搜索，在搜索过程中同时在前缀树上行走，如果当前路径在前缀树中不存在则立即剪枝返回，这样可以一次DFS同时匹配多个单词。

使用pass数组记录每个前缀树节点下还有多少个待匹配的单词，当找到一个单词后，回溯路径上的所有pass值都减去对应数量，如果某个节点的pass变为0说明该分支下已无待匹配单词可以提前终止。

为了避免重复，找到的单词会立即从end数组中删除，并且搜索过程中通过临时标记访问过的格子来防止走回头路。

### 代码实现

```java
public static final int MAXN = 10001;
    public static int[][] tree = new int[MAXN][26];
    public static int[] pass = new int[MAXN];
    public static String[] end = new String[MAXN];
    public static int cnt;
    
    public static List<String> findWords(char[][] board, String[] words) {
        build(words);
        List<String> ans = new ArrayList<>();
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[0].length; j++) {
                dfs(board, i, j, 1, ans);
            }
        }
        clear();
        return ans;
    }
    
    public static int dfs(char[][] board, int i, int j, int t, List<String> ans) {
    // 边界检查：越界或者已访问过（board[i][j]==0表示已访问）
    if (i < 0 || i == board.length || j < 0 || j == board[0].length || board[i][j] == 0) {
        return 0;
    }
    
    char tmp = board[i][j];  // 保存当前字符，回溯时要恢复
    int road = tmp - 'a';     // 字符转换为路径编号
    t = tree[t][road];        // 在前缀树上走一步
    
    // 剪枝：如果前缀树这个节点下没有待匹配的单词了，直接返回
    if (pass[t] == 0) {
        return 0;
    }
    
    int fix = 0;  // 记录从这个位置开始找到了几个单词
    
    // 如果当前节点是某个单词的结尾，收集这个单词
    if (end[t] != null) {
        fix++;
        ans.add(end[t]);
        end[t] = null;  // 置空，避免重复收集
    }
    
    // 标记当前位置已访问（防止走回头路）
    board[i][j] = 0;
    
    // 向四个方向继续搜索
    fix += dfs(board, i - 1, j, t, ans);  // 上
    fix += dfs(board, i + 1, j, t, ans);  // 下
    fix += dfs(board, i, j - 1, t, ans);  // 左
    fix += dfs(board, i, j + 1, t, ans);  // 右
    
    // 回溯：恢复现场
    pass[t] -= fix;      // 更新这个节点下剩余的单词数
    board[i][j] = tmp;   // 恢复字符，供其他路径使用
    
    return fix;
}
    
    public static void build(String[] words) {
    cnt = 1;  // 节点编号从1开始，1是根节点
    for (String word : words) {
        int cur = 1;  // 从根节点开始
        pass[cur]++;  // 根节点下的单词数+1
        
        for (int i = 0; i < word.length(); i++) {
            int path = word.charAt(i) - 'a';  // 当前字符对应的路径编号
            if (tree[cur][path] == 0) {  // 如果这条路不存在
                tree[cur][path] = ++cnt;  // 创建新节点
            }
            cur = tree[cur][path];  // 走到下一个节点
            pass[cur]++;  // 这个节点下的单词数+1
        }
        end[cur] = word;  // 在单词结尾节点存储完整单词
    }
}
    
    public static void clear() {
        for (int i = 1; i <= cnt; i++) {
            Arrays.fill(tree[i], 0);
            pass[i] = 0;
            end[i] = null;
        }
    }
    

```

---
如果觉得有帮助，欢迎点赞、关注、转发~


