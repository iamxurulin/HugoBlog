---
title: "Leetcode765情侣牵手"
date: 2026-01-03 20:56:51
categories:
  - 算法
tags:
  - leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/51cc9122304c48a5bd9dc10fd745dc26.jpeg#pic_center)

### 代码求解

初始化并查集，每对情侣初始集合只有自身，遍历数组，计算相邻两人情侣编号并合并，合并之后集合数量减一，最后用总情侣对数减去集合数量得到结果。

```java
public static int minSwapsCouples(int[] row){
		int n = row.length;
		build(n/2);
		for(int i=0;i<n;i+=2){
			union(row[i]/2,row[i+1]/2);
		}
		return n/2-sets;
	}

	public static int MAXN = 31;
	public static int[] father = new int[MAXN];
	public static int sets;

	public static void build(int m){
		for(int i=0;i<m;i++){
			father[i]=i;
		}
		sets = m;
	}

	public static int find(int i){
		if(i!=father[i]){
			father[i]=find(father[i]);
		}
		return father[i];
	}

	public static void union(int x,int y){
		int fx = find(x);
		int fy = find(y);
		if(fx!=fy){
			father[fx]=fy;
			sets--;
		}
	}
```
