---
title: "【回溯】N皇后问题"
date: 2026-01-19 00:24:00
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/4b3c15985b684f6e953dc2769eb2d008.jpeg#pic_center)
### 求解代码

```java
    private int ans = 0;   
    public int Nqueen(int n) {
        int[] pos = new int[n];
        backtrack(n, 0, pos);
        return ans;
    }

    private boolean isValid(int[] pos,int row,int col){
        for(int i=0;i<row;i++){
            if(pos[i]==col||Math.abs(row-i)==Math.abs(col-pos[i])){
                return false;
            }
        }
        return true;
    }

    private void backtrack(int n,int row,int[] pos){
        if(row==n){
            ans++;
            return;
        }

        for(int i=0;i<n;i++){
            if(isValid(pos, row, i)){
                pos[row]=i;
                backtrack(n, row+1, pos);
            }
        }
    }
```
### 小贴士

1.`pos[i]==col||Math.abs(row-i)==Math.abs(col-pos[i]`这个校验逻辑为什么是这样？

主要是因为回溯是逐行递归，一行只放一个皇后，天然**规避同行冲突**，所以这里没有写`i==row`;

然后利用了对角线的数学判定公式：

两个皇后的【行号差值的绝对值】 = 【列号差值的绝对值】➡️必在同一条对角线上

2.在 N 皇后问题中，行不会重复选（遍历规则）、列不会重复选（校验规则），`used`数组的使命已经被替代，所以不需要写 `used` 数组。

3.本题的回溯为什么不需要显式写撤销代码？

做选择时只修改了**当前层级专属**的变量，且变量会被下一次**循环**自动覆盖，覆盖之后，旧值就消失了，相当于**恢复成了原始状态**。
