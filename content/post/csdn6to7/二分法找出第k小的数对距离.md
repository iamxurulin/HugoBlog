---
title: "二分法找出第k小的数对距离"
date: 2025-12-27 20:10:12
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/54ab287974d947ea8d6fa641a28b04d2.jpeg#pic_center)
### 代码求解

#### smallestDistancePair方法
先排序，用最大值减去最小值求出最大的数对距离。

通过二分法调用f函数找出区间内满足要求的数对，然后不停地二分。


```java
	public static int smallestDistancePair(int[] nums,int k){
		int n = nums.length;
		Arrays.sort(nums);
		int ans = 0;
		for(int l=0,r=nums[n-1]-nums[0],m,cnt;l<=r;){
			m = l+((r-l)>>1);
			cnt = f(nums,m);
			if(cnt>=k){
				ans = m;
				r = m-1;
			}else{
				l=m+1;
			}
		}
		return ans;
	}
```
#### f方法
求arr中数对距离小于limit的数对总共有几对。

```java
	public static int f(int[] arr,int limit){
		int ans = 0;
		for(int l=0,r=0;l<arr.length;l++){
			while(r+1<arr.length && arr[r+1]-arr[l]<=limit){
				r++;
			}
			ans+=r-l;
		}
		return ans;
	}
```

