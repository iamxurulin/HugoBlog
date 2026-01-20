---
title: "合并k个已排序的链表"
date: 2026-01-07 21:30:37
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/8cada47537884726aef8b1535290d1d4.jpeg#pic_center)
### 求解代码

```java
public static ListNode mergeKLists(ArrayList<ListNode> arr) {
        // 初始化小顶堆：按节点值升序排序，每次取出当前最小的节点
        PriorityQueue<ListNode> pq = new PriorityQueue<ListNode>((a, b) -> (a.val - b.val));
        
        // 将非空的头节点加入小顶堆
        for (int i = 0; i < arr.size(); i++) { 
            ListNode head = arr.get(i);
            if (head != null) { // 跳过空链表，避免堆中加入null
                pq.add(head);
            }
        }

        // 哨兵节点：简化链表拼接逻辑，无需处理头节点为空的情况
        ListNode dummy = new ListNode(-1);
        ListNode curr = dummy; // 合并链表的尾节点指针，初始指向哨兵节点

        while (!pq.isEmpty()) {
            ListNode minNode = pq.poll(); // 取出当前所有链表的最小节点
            curr.next = minNode;          // 拼接到合并链表尾部
            curr = curr.next;             // 尾节点指针后移

            // 若当前最小节点的下一个节点非空，加入堆中继续参与排序
            if (minNode.next != null) {
                pq.add(minNode.next);
            }
        }

        // 哨兵节点的next即为合并后的真实头节点
        return dummy.next;
    }
```

