---
title: "这道LeetCode-Hard题-用一个转化思想就变简单了"
date: 2025-12-11 21:55:43
categories:
- 算法
tags:
  - HashMap
draft: false
---

![在这里插入图片描述](/images/06ca2a4f62d2481289f853c58e90eaec-08c07329.jpeg)
### 求解思路

这道题将"恰好k种"这个条件转化为两个"最多k种"的问题相减。

我们可以这样理解：

如果我们知道有多少个子数组最多包含k种不同数字,再减去最多包含k-1种不同数字的子数组个数,剩下的就是恰好包含k种不同数字的子数组。

想象有一个可伸缩的窗口在数组上滑动,右指针不断向右扩展窗口,每次加入一个新数字就用计数器记录它出现的次数,如果这个数字是第一次出现就让种类数加1。

当窗口内的数字种类超过k时,我们就移动左指针收缩窗口,同时减少对应数字的计数,如果某个数字的计数变为0就让种类数减1,直到窗口内的种类数重新满足不超过k的条件。

在这个过程中,每当右指针固定在某个位置时,从左指针到右指针之间的所有子数组都是满足条件的,所以每次我们把当前窗口的长度也就是r-l+1累加到答案中。

这样遍历完整个数组后,就得到了所有最多包含k种不同数字的子数组总数。

代码实现上,我们使用一个计数数组cnts来记录每个数字在当前窗口中出现的次数,用collect变量维护当前窗口内不同数字的种类数。

通过这种方式,只需要遍历两遍数组分别计算"最多k种"和"最多k-1种",然后做个减法就能得到"恰好k种"的答案。

### 完整代码

```java
public static int subarraysWithKDistinct(int[] arr, int k) {
    return numsOfMostKinds(arr, k) - numsOfMostKinds(arr, k - 1);
}

public static int MAXN = 20001;

public static int[] cnts = new int[MAXN];

// arr中有多少子数组,数字种类不超过k
// arr的长度是n,arr里的数值1~n之间
public static int numsOfMostKinds(int[] arr, int k) {
    Arrays.fill(cnts, 1, arr.length + 1, 0);
    int ans = 0;
    for (int l = 0, r = 0, collect = 0; r < arr.length; r++) {
        if (++cnts[arr[r]] == 1) {
            collect++;
        }
        while (collect > k) {
            if (--cnts[arr[l++]] == 0) {
                collect--;
            }
        }
        ans += r - l + 1;
    }
    return ans;
}
```

---
如果觉得有帮助，欢迎点赞、关注、转发~
