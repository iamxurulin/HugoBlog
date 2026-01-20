---
title: "Leetcode239滑动窗口最大值"
date: 2025-12-31 21:20:32
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/aae4bacca2614ed299552c193dcd59a5.jpeg#pic_center)
### 求解代码
准备一个数组作为双端队列deque，用h（head）和t（tail）表示队列的头和尾位置。

双端队列要维持从左往右大到小的顺序。

```java
public static int MAXN = 100001;
	public static int[] deque = new int[MAXN];
	public static int h,t;
	public static int[] maxSlidingWindow(int[] arr,int k){
		h = t = 0;
		int n = arr.length;
		for(int i=0;i<k-1;i++){
			while(h<t&&arr[deque[t-1]]<=arr[i]){
				t--;
			}
			deque[t++]=i;
		}

		int m = n-k+1;
		int[] ans = new int[m];
		for(int l=0,r=k-1;l<m;l++,r++){
			while(h<t&&arr[deque[t-1]]<=arr[r]){
				t--;
			}
			deque[t++]=r;
			ans[l]=arr[deque[h]];
			if(deque[h]==l){
				h++;
			}
		}
		return ans;
	}
```

