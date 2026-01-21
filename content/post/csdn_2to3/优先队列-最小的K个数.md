---
title: "优先队列-最小的K个数"
date: 2026-01-16 07:58:54
categories:
- 算法
tags:
  - 堆
draft: false
---

![在这里插入图片描述](/images/2839d4115a2049069674b50fccc7d907-2141bcac.jpeg)
### 求解代码

```java
public ArrayList<Integer> GetLeastNumbers_Solution (int[] input, int k) {
        ArrayList<Integer> ans = new ArrayList<>();
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b)->(b - a));

        if (input == null || k <= 0 || input.length == 0) {
            return ans;
        }
        for (int val : input) {
            if (pq.size() < k) {
                pq.add(val);
            } else {
                if (pq.peek() > val) {
                    pq.poll();
                    pq.add(val);
                }
            }
        }

        while (!pq.isEmpty()) {
            ans.add(pq.poll());
        }

        return ans;
    }
```

### 小贴士

这里解释一下为什么是 `pq.size() < k`？

`pq.size() < k` 意味着**只要堆里的元素还没凑够 k 个**，就无脑往堆里加元素，不用任何筛选；

当 `pq.size() == k` 时，堆就「**满了**」，此时会进入 else 分支，也就是【筛选替换阶段】，堆顶就是「当前筛选出的最小 k 个数的最大值」，这个值就是**筛选门槛**，
所有后续遍历到的数字，都只用和这个「**门槛**」比较就行。

如果写成了`pq.size() <= k`，就变成了只要堆里的元素 `≤k` 个，就继续往堆里加元素到`size=k`的时候，`size<=k`是 true，但是执行 `add` 之后，下一次循环的判断条件还是`pq.size()<=k`，此时 `size=k`，依然是 `true`，但堆的 `size` 不会再涨了，堆永远不会进入 `else` 筛选替换分支，从头到尾只会无脑入堆，`else`分支里的逻辑完全失效。
