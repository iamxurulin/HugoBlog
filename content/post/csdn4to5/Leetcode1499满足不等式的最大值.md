---
title: "Leetcode1499满足不等式的最大值"
date: 2026-01-02 23:20:11
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/877f3d9774164b079f36fad39a2074ff.jpeg#pic_center)

### 问题分析
双端队列按照y-x的值从大到小组织，队列中存储点的编号。

如果y-x的值大于队列尾部元素的y-x值，则从尾部弹出元素。

如果当前点的x值与队列头部元素的x值之差大于k时，则从头部弹出元素。

### 求解代码

```java
public static int MAXN = 100001;
	public static int[][] deque = new int[MAXN][2];
	public static int h,t;

	public static int findMaxValueOfEquation(int[][] points,int k){
		h = t = 0;
		int n = points.length;
		int ans = Integer.MIN_VALUE;
		for(int i=0,x,y;i<n;i++){
			x=points[i][0];
			y=points[i][1];

			while (h<t&&deque[h][0]+k<x) {
				h++;
			}

			if(h<t){
				ans = Math.max(ans, x+y+deque[h][1]-deque[h][0]);
			}

			while (h<t&&deque[t-1][1]-deque[t-1][0]<=y-x) {
				t--;
			}

			deque[t][0]=x;
			deque[t++][1]=y;
		}
		return ans;
	}
```

