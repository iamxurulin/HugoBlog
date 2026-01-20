---
title: "Leetcode839相似字符串组"
date: 2026-01-03 21:34:46
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/5fd0987f02444aa99d1cceded786c92c.jpeg#pic_center)
### 题目分析
从0~n-1遍历单词，每个单词与后续单词进行比较，如果不在同一集合且相似则合并。

遍历两个字符串，记录不同位置的数量，如果不同位置的数量在2个以内则相似，超过了2个则不相似。
### 求解代码

```java
public static int MAXN = 301;
	public static int[] father = new int[MAXN];
	public static int sets;
	public static void build(int n){
		for(int i=0;i<n;i++){
			father[i]=i;
		}
		sets = n;
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

	public static int numSimilarGroups(String[] strs){
		int n = strs.length;
		int m = strs[0].length();
		build(n);

		for(int i=0;i<n;i++){
			for(int j=i+1;j<n;j++){
				if(find(i)!=find(j)){
					int diff = 0;
					for(int k=0;k<m&&diff<3;k++){
						if(strs[i].charAt(k)!=strs[j].charAt(k)){
							diff++;
						}
					}
					if(diff==0||diff==2){
						union(i, j);
					}
				}
			}
		}
		return sets;
	}
```

