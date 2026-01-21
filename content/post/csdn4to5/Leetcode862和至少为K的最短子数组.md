---
title: "Leetcode862和至少为K的最短子数组"
date: 2026-01-01 21:49:49
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](/images/503f5cb71e4b489584c3fe47b82426c5-5abf5f4d.jpeg)

### 题目分析
遍历数组，对于每个位置i，假设子数据必须以i作为右边界，求出往左延伸多短，能够让累加和大于等于K，最后从所有答案中选择最小值。

准备一个双端队列，要求从头到尾严格小到大。
当来到位置i，0~i范围的前缀和为x时，从头部依次考察，如果x减去队列头部指示的前缀和达标，则记录答案并将头部元素弹出，因为后续位置使用该前缀和得到的结果不会更短。

加入新的前缀和时，如果不满足队列小到大的顺序，则从尾部弹出元素。
### 求解代码

```java
public static int MAXN = 100001;
	public static long[] sum = new long[MAXN];
	public static int[] deque = new int[MAXN];
	public static int h,t;
	public static int shortestSubarray(int[] arr,int K){
		int n = arr.length;
		for(int i = 0;i<n;i++){
			sum[i+1]=sum[i]+arr[i];
		}
		h=t=0;
		int ans = Integer.MAX_VALUE;
		for(int i=0;i<=n;i++){
			while (h!=t&&sum[i]-sum[deque[h]]>=K) {
				ans = Math.min(ans, i-deque[h++]);
			}

			while (h!=t&&sum[deque[t-1]]>=sum[i]) {
				t--;
			}
			deque[t++]=i;
		}
		return ans!=Integer.MAX_VALUE?ans:-1;
	}
```

