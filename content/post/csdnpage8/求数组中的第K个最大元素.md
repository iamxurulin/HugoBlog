---
title: "求数组中的第K个最大元素"
date: 2025-10-04 11:45:06
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/d875a5fef4b346389e3552e204c7a0c5.png#pic_center)
本文采用随机选择算法来解决这道题。

题目要求找到数组 nums 中第 k 大的元素。

我们可以将问题转化为找到数组中第 nums.length - k 小的元素。

```java
	public static int findKthLargest(int[] nums,int k){
		return randomizedSelect(nums,nums.length-k);
	}
```

### 选择的核心逻辑
每次随机选一个 pivot，然后做三路划分：
• 如果目标索引在左边，就往左区间继续找
• 如果在右边，就往右区间找
• 如果刚好落在等于 pivot 的区域，直接返回

```java
public static int randomizedSelect(int[] arr,int i){
		int ans=0;
		for(int l=0,r=arr.length-1;l<=r;){
			partition(arr,l,r,arr[l+(int)(Math.random()*(r-l+1))]);
			if(i<first){
				r=first-1;
			}else if(i>last){
				l=last+1;
			}else{
				ans = arr[i];
				break;
			}
		}
		return ans;
	}
```
### 三路划分
把数组分成三块：

[l, first): 小于 pivot
[first, last]: 等于 pivot
(last, r]: 大于 pivot
```java
public static void partition(int[] arr, int l, int r, int x) {
    first = l;  // 小于x区域的右边界
    last = r;   // 大于x区域的左边界
    int i = l;
    
    while(i <= last) {
        if(arr[i] == x) {
            i++;  // 等于就跳过
        } else if(arr[i] < x) {
            swap(arr, first++, i++);  // 小于就扔左边
        } else {
            swap(arr, i, last--);     // 大于就扔右边
        }
    }
}
```

**代码**
链接：https://pan.quark.cn/s/db66ccaf0511
提取码：62Vk
