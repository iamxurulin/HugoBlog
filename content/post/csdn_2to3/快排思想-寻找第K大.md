---
title: "【快排思想】寻找第K大"
date: 2026-01-16 07:59:31
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/e07bbc56d6d94bc39d9caadf2301b5e7.jpeg#pic_center)
### 求解代码

```java
private void swap(int[] arr,int i,int j){
        if(i!=j){
            arr[i]^=arr[j];
            arr[j]^=arr[i];
            arr[i]^=arr[j];
        }
    }
    public int findKth (int[] a, int n, int K) {
        K=n-K;

        int low = 0,high = n-1;

        while(low<=high){

            int i = low;

            for(int j=low+1;j<=high;j++){
                if(a[j]<a[low]){
                    swap(a,j,++i);
                }
            }
            swap(a, low, i);
            if(K==i){
                return a[i];
            }else if(K<i){
                high=i-1;
            }else{
                low=i+1;
            }        
        }
        return -1;

    }
```

### 小贴士

数组中第`K`大的数对应的就是数组下标为`n-K`的数
