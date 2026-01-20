---
title: "DFS-矩阵最长递增路径"
date: 2026-01-19 00:23:17
categories:
- 算法
tags:
  - 搜索
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/da0fca9d125748a3b246382252aa5e6e.jpeg#pic_center)
![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/5ffaddbf6aa14c85a8e43dc756eebec1.jpeg#pic_center)
### 求解代码

```java
private int m, n;

    private int dfs(int[][] matrix, int[][] dp, int i, int j) {
        // 记忆化：已经计算过该位置的最长路径，直接返回
        if (dp[i][j] != 0) {
            return dp[i][j];
        }
        
        dp[i][j]++;

        
        if (i - 1 >= 0 && matrix[i - 1][j] > matrix[i][j]) {
            dp[i][j] = Math.max(dp[i][j], dfs(matrix, dp, i - 1, j) + 1);
        }
        
        if (i + 1 < m && matrix[i + 1][j] > matrix[i][j]) {
            dp[i][j] = Math.max(dp[i][j], dfs(matrix, dp, i + 1, j) + 1);
        }
        
        if (j - 1 >= 0 && matrix[i][j - 1] > matrix[i][j]) {
            dp[i][j] = Math.max(dp[i][j], dfs(matrix, dp, i, j - 1) + 1);
        }
        
        if (j + 1 < n && matrix[i][j + 1] > matrix[i][j]) {
            dp[i][j] = Math.max(dp[i][j], dfs(matrix, dp, i, j + 1) + 1);
        }
        
        return dp[i][j];
    }

    public int solve(int[][] matrix) {
        
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        int ans = 0;
        m = matrix.length;
        n = matrix[0].length;
        
        int[][] dp = new int[m][n];

        // 遍历矩阵的每一个单元格，作为递增路径的起点
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                ans = Math.max(ans, dfs(matrix, dp, i, j));
            }
        }
        return ans;
    }
```

### 小贴士
`dp[i][j]`是以矩阵中第 `i` 行 `j` 列的单元格为**起点**的最长递增路径的长度。

如果计算过`dp[i][j]`，就会把结果存入数组，后续再递归到这个单元格时，可直接返回结果。

说说代码`Math.max(dp[i][j], dfs(matrix, dp, i + 1, j) + 1)`：

`dp[i][j]`是当前单元格「已经算出的最长路径长度」；

`dfs(...) +1`是当前单元格「走上下左右的某个方向能得到的路径长度」；
