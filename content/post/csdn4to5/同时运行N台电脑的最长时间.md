---
title: "同时运行N台电脑的最长时间"
date: 2025-12-28 19:56:01
categories:
- 算法
tags:
  - 数组
draft: false
---

![在这里插入图片描述](/images/2976e7749f424bddb98a4782b6518fc2-5e0c3708.jpeg)
![在这里插入图片描述](/images/27be018f117b4a458f0f0aa9da5f25a8-c99c269b.jpeg)
### 求解代码

#### maxRunTime方法

假设所有电池的最大电量是max，如果此时sum>(long)max*num，那么最终的供电时间一定会大于等于max，由此也能推出最终的答案为sum/num。

对于sum<=(long)max*num的情况，在0~max区间内不断二分查找即可。

```java
	public static long maxRunTime(int num,int[] arr){
		int max = 0;
		long sum = 0;
		for(int x:arr){
			max = Math.max(max,x);
			sum+=x;
		}

		if(sum>(long)max*num){
			return sum/num;
		}

		int ans = 0;
		for(int l=0,r=max,m;l<=r;){
			m= l+((r-l)>>1);
			if(f(arr,num,m)){
				ans = m;
				l = m+1;
			}else{
				r=m-1;
			}
		}
		return ans;
	}

```
#### f方法

```java
	public static boolean f(int[] arr, int num, int time) {
		long sum = 0;
		for (int x : arr) {
			if (x > time) {
				num--;
			} else {
				sum += x;
			}
			if (sum >= (long) num * time) {
				return true;
			}
		}
		return false;
	}
```

