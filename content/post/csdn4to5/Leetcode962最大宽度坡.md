---
title: "Leetcode962最大宽度坡"
date: 2025-12-30 20:05:05
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](/images/d43a596609a8437293f4945618aeafc4-44369a73.jpeg)

### 问题分析
这道题采用小压大的单调栈求解。

从左往右遍历数组，只有依次小压大这种下降趋势的下标才有必要收集进单调栈。

收集完单调栈后，从右往左遍历数组。

假设当前的右侧位置为最右下标，依次看其与栈中的左侧下标是否能构成坡。

如果可以构成，则计算宽度并更新最大宽度答案，同时弹出该左侧下标。

初始化栈的时候，栈的大小为1，相当于是把0下标放入栈中。


### 求解代码

```java
	public static int MAXN = 50001;
	public static int[] stack = new int[MAXN];
	public static int r;
	public static int maxWidthRamp(int[] arr){
		r =1;
		int n = arr.length;
		for(int i=1;i<n;i++){
			if(arr[stack[r-1]]>arr[i]){
				stack[r++]=i;
			}
		}
		int ans = 0;
		for(int j=n-1;j>=0;j--){
			while(r>0&& arr[stack[r-1]]<=arr[j]){
				ans = Math.max(ans,j-stack[--r]);
			}
		}
		return ans;
	}
```

