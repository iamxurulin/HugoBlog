---
title: "LeetCode-1124-表现良好的最长时间段"
date: 2025-11-27 21:18:29
categories:
- 算法
tags:
  - HashMap
draft: false
---

![在这里插入图片描述](/images/2507893a01ad480b893d4d46b76f2df3-1477cbdf.jpeg)
### 解题思路

这道题我们把工作时间大于8小时的天数记为+1,小于等于8小时的记为-1,这样问题就转化为求和大于0的最长子数组。

计算过程中维护一个前缀和：

如果当前前缀和大于0,说明从开头到当前位置就是一个有效时间段;


如果前缀和小于等于0,我们需要找到最早出现"sum-1"的位置j,因为从j的下一个位置到当前位置i这段区间的和等于sum-(sum-1)=1(大于0),这样就找到了一个有效区间。

用哈希表记录每个前缀和最早出现的位置,确保找到的区间是最长的,遍历一遍数组即可得到答案。

### 代码实现

```java
public static int longestWPI(int[] hours) {
    // 某个前缀和,最早出现的位置
    HashMap<Integer, Integer> map = new HashMap<>();
    // 0这个前缀和,最早出现在-1,一个数也没有的时候
    map.put(0, -1);
    int ans = 0;
    for (int i = 0, sum = 0; i < hours.length; i++) {
        sum += hours[i] > 8 ? 1 : -1;
        if (sum > 0) {
            ans = i + 1;
        } else {
            // sum <= 0
            if (map.containsKey(sum - 1)) {
                ans = Math.max(ans, i - map.get(sum - 1));
            }
        }
        if (!map.containsKey(sum)) {
            map.put(sum, i);
        }
    }
    return ans;
}
```

---
如果觉得有帮助，欢迎点赞、关注、转发~

