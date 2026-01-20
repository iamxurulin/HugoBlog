---
title: "【DFS】岛屿数量"
date: 2026-01-18 05:00:00
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/a9a1f872636d45048a2cc12b7b8feab2.jpeg#pic_center)
### 求解代码

```java
public int solve (char[][] grid) {
        int ans = 0;
        int m = grid.length,n =grid[0].length;
        for(int i=0;i<m;i++){
            for(int j=0;j<n;j++){
                if(grid[i][j]=='1'){
                    ans++;
                    dfs(grid, i, j);
                }
            }
        }
        return ans;
    }

    private void dfs(char[][] grid,int i,int j){
        if(i<0||j<0||i>=grid.length||j>=grid[0].length){
            return;
        }


        if(grid[i][j]=='0'){
            return;
        }

        grid[i][j]='0';
        dfs(grid, i-1, j);
        dfs(grid, i+1, j);
        dfs(grid, i, j-1);
        dfs(grid, i, j+1);
    }
```
### 小贴士
1.这道题，发现一块陆地 `grid[i][j]='1'` 时，立刻把这块陆地，以及和它相连的所有陆地，全部修改为海水 `'0'`，这样做可以实现用原数组本身做**访问标记**，这样就不需要额外创建 `boolean[][] used` 数组了。

2.解释一下代码里是 `看到1就ans++`，为什么不会把同一块相连的 `1` 重复计数？

其实，`ans++` 并不是见到 `1` 就加，而是什么呢？

是这样的，发现了一个全新的、独立的岛屿的起点，这个时候岛屿数量就会 `+ 1`，我们还要**注意**紧跟的 `dfs(grid,i,j)` 。

这个`dfs`会把岛屿的起点所属的一整块相连的所有 `1`，全部永久变成 `0`，这么做就能够实现一个岛屿，只会触发 `1` 次 `ans++`
