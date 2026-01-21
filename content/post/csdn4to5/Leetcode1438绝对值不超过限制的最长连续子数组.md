---
title: "Leetcode1438绝对值不超过限制的最长连续子数组"
date: 2026-01-01 20:50:33
categories:
- 算法
tags:
  - 数组
draft: false
---

![在这里插入图片描述](/images/15c5340cf8e0442ba6f39ab6f9acf33f-82b6a8e7.jpeg)

### 题目分析
如果一个子数组达标，也就是它内部的最大值减去最小值小于等于给定限制limit， 则其内部任意小范围一定也达标，因为范围变小，最大值只可能变小或者不变，而最小值只可能变大或者不变。

如果一个子数组不达标，则再扩大范围一定会更加不达标，因为范围变大，最大值只可能上升或者不变，而最小值只可能下降或者不变。

先固定左边界l，右边界r不断右移扩展窗口，每次判断新加入的数是否使窗口达标，如果达标，则继续拓展，不达标则停止，计算以当前l开头的达标子数组的最大长度。


### 求解代码

```java
	public static int MAXN = 100001;

	public static int[] maxDeque = new int[MAXN];
	public static int[] minDeque = new int[MAXN];

	public static int maxh,maxt,minh,mint;
	public static int[] arr;
	public static int longestSubarray(int[] nums,int limit){
		maxh = maxt = minh = mint = 0;
		arr = nums;
		int n = arr.length;
		int ans = 0;
		for(int l=0,r=0;l<n;l++){
			while(r<n&&ok(limit,nums[r])){
				push(r++);
			}
			ans = Math.max(ans, r-l);
			pop(l);
		}
		return ans;
	}

	public static boolean ok(int limit,int number){
		int max = maxh <maxt?Math.max(arr[maxDeque[maxh]], number):number;
		int min = minh <mint?Math.min(arr[minDeque[minh]], number):number;
		return max-min<=limit;
	}

	public static void push(int r){
		while (maxh<maxt&&arr[maxDeque[maxt-1]]<=arr[r]) {
			maxt--;
		}
		maxDeque[maxt++]=r;
		while (minh<mint&&arr[minDeque[mint-1]]>=arr[r]) {
			mint--;
		}
		minDeque[mint++]=r;
	}

	public static void pop(int l) {
		if (maxh < maxt && maxDeque[maxh] == l) {
			maxh++;
		}
		if (minh < mint && minDeque[minh] == l) {
			minh++;
		}
	}	

```

