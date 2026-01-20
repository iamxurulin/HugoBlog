---
title: "【并查集】Leetcode947移除最多的同行或同列石头"
date: 2026-01-03 23:05:05
categories:
- 算法
tags:
- 算法
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/c2a8933484ba4cf8946bb3c742fa9a60.jpeg#pic_center)
### 求解代码

```java
	public static HashMap<Integer,Integer> rowFirst = new HashMap<Integer,Integer>();
	public static HashMap<Integer,Integer> colFirst = new HashMap<Integer,Integer>();

	public static int MAXN = 1001;
	public static int[] father = new int[MAXN];

	public static int sets;

	public static void build(int n){
		rowFirst.clear();
		colFirst.clear();
		for(int i=0;i<n;i++){
			father[i]=i;
		}
		sets = n;
	}

	public static int find(int i){
		if (i!=father[i]) {
			father[i]=find(father[i]);
		}
		return father[i];
	}

	public static void union(int x,int y){
		int fx = find(x);
		int fy = find(y);
		if (fx!=fy) {
			father[fx]=fy;
			sets--;
		}
	}

	public static int removeStones(int[][] stones){
		int n = stones.length;
		build(n);

		for(int i =0;i<n;i++){
			int row = stones[i][0];
			int col = stones[i][1];
			if(!rowFirst.containsKey(row)){
				rowFirst.put(row, i);
			}else{
				union(i, rowFirst.get(row));
			}

			if(!colFirst.containsKey(col)){
				colFirst.put(col, i);
			}else{
				union(i, colFirst.get(col));
			}
		}
		return n-sets;
	}
```

