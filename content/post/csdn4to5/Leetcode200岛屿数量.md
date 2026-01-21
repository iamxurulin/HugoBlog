---
title: "Leetcode200岛屿数量"
date: 2026-01-03 22:25:01
categories:
- 算法
tags:
  - 搜索
draft: false
---

![在这里插入图片描述](/images/b8abb91dbc8644cc9a260988f3963f82-2e160151.jpeg)
### 题目分析
要区分二维矩阵中的每个1，需要将二维问题转化为一维编号问题。

如果矩阵有m列，位于第i行、第j列的元素对应的一维编号为i乘以m加j。

先将所有的1建成小集合，遍历矩阵，遇到1时，如果其左边或者上边有1则进行合并，最后统计并查集中集合的数量就是岛的数量。
### 代码求解

```java
public static int numIslands(char[][] board){
		int n = board.length;
		int m = board[0].length;

		build(n,m,board);
		for(int i=0;i<n;i++){
			for(int j=0;j<m;j++){
				if(board[i][j]=='1'){
					if(j>0&&board[i][j-1]=='1'){
						union(i,j,i,j-1);
					}

					if(i>0&&board[i-1][j]=='1'){
						union(i,j,i-1,j);
					}
				}
			}
		}
		return sets;
	}

	public static int MAXSIZE = 100001;
	public static int[] father = new int[MAXSIZE];
	public static int cols;
	public static int sets;

	public static void build(int n,int m,char[][] board){
		cols = m;
		sets = 0;
		for(int a=0;a<n;a++){
			for(int b=0,index;b<m;b++){
				if(board[a][b]=='1'){
					index = index(a,b);
					father[index]=index;
					sets++;
				}
			}
		}
	}

	public static int index(int a,int b){
		return a*cols+b;
	}

	public static int find(int i){
		if(i!=father[i]){
			father[i]=find(father[i]);
		}
		return father[i];
	}

	public static void union(int a,int b,int c,int d){
		int fx = find(index(a, b));
		int fy = find(index(c, d));
		if(fx!=fy){
			father[fx]=fy;
			sets--;
		}
	}
```

