---
title: "使子数组和能被P整除"
date: 2025-11-28 21:46:29
categories:
- 算法
tags:
  - HashMap
draft: false
---

![在这里插入图片描述](/images/5382c836dc024de99fb70ee298574370-ce902afd.png)
### 求解思路

首先计算整个数组的和对p取模得到余数mod，如果mod为0说明已经满足条件直接返回0。

移除一段子数组后，剩余部分的和能被p整除，等价于找到一个子数组其和模p的余数恰好等于mod。

利用前缀和的性质，如果前缀和pre[j] - pre[i]的余数等于mod，那么移除(i, j]这段区间即可。

为了快速查找符合条件的左端点，用哈希表存储每个余数最晚出现的位置，遍历时对于当前位置i的前缀和余数cur，需要找到之前某个位置的余数find满足(cur - find) % p = mod，变换后得到find = (cur - mod + p) % p，从哈希表中查询find是否存在即可更新最短长度。

### 代码实现

```java
public int minSubarray(int[] nums, int p) {
    // 计算整体余数
    int mod = 0;
    for (int num : nums) {
        mod = (mod + num) % p;
    }
    if (mod == 0) {
        return 0;
    }
    
    // key: 前缀和%p的余数, value: 最晚出现的位置
    HashMap<Integer, Integer> map = new HashMap<>();
    map.put(0, -1);
    int ans = Integer.MAX_VALUE;
    
    for (int i = 0, cur = 0, find; i < nums.length; i++) {
        // 当前前缀和的余数
        cur = (cur + nums[i]) % p;
        // 需要找的余数
        find = cur >= mod ? (cur - mod) : (cur + p - mod);
        
        if (map.containsKey(find)) {
            ans = Math.min(ans, i - map.get(find));
        }
        map.put(cur, i);
    }
    
    return ans == nums.length ? -1 : ans;
}
```

---
如果觉得有帮助，欢迎点赞、关注、转发~
