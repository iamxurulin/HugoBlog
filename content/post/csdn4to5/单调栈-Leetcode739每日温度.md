---
title: "单调栈-Leetcode739每日温度"
date: 2025-12-29 21:31:19
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](/images/42fea2b7a39b42eaa7219360a945397b-9a06441e.jpeg)
### 代码求解
求更高温度出现在几天后，这是一个严格大于的问题，需要使用小压大的单调栈。

```java
class Solution {
    public static int MAXN = 100001;

	public static int[] stack = new int[MAXN];

	public static int r;

	public static int[] dailyTemperatures(int[] nums){
		int n = nums.length;
		int[] ans = new int[n];
		r = 0;
		for(int i=0,cur;i<n;i++){
			while (r>0&&nums[stack[r-1]]<nums[i]) {
				cur = stack[--r];
				ans[cur]=i-cur;
			}
			stack[r++]=i;
		}
		return ans;
	}
}
```

