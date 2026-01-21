---
title: "Floyd判圈算法"
date: 2025-10-18 10:33:19
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](/images/ba4d56a773ae44a29e485735285a7b02-c18e2070.png)
这个问题在实际开发中也有应用场景,比如检测循环引用、内存泄漏分析等。

本文介绍Floyd判圈算法来解决这道题。

### 代码逻辑
设置两个指针,慢指针(slow)每次走一步,快指针(fast)每次走两步。

如果链表存在环,快指针最终一定会追上慢指针；

如果链表不存在环,快指针会先到达链表末尾。



当快慢指针相遇后,问题就变成了:如何找到环的入口?

这里用到了一个的数学性质:

从起点到环入口的距离,等于从相遇点继续走到环入口的距离。

因此,我们只需将一个指针移回起点，然后两个指针都以相同速度前进，当它们再次相遇的位置,就是环的入口。

### 代码实现

```java
public static ListNode detectCycle(ListNode head) {
    // 链表为空或节点数少于3个,不可能形成环
    if (head == null || head.next == null || head.next.next == null) {
        return null;
    }
    
    // 初始化快慢指针
    ListNode slow = head.next;
    ListNode fast = head.next.next;
    
    // 检测是否存在环
    while (slow != fast) {
        // 快指针到达末尾,说明无环
        if (fast.next == null || fast.next.next == null) {
            return null;
        }
        slow = slow.next;
        fast = fast.next.next;
    }
    
    // 找到环的入口
    // 将fast指针移回起点
    fast = head;
    // 两个指针以相同速度前进
    while (slow != fast) {
        slow = slow.next;
        fast = fast.next;
    }
    
    // 相遇点即为环的入口
    return slow;
}
```





