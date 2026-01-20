---
title: "删除链表的倒数第n个节点"
date: 2026-01-08 20:11:33
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/0c6a482eea2b49b5abf39b273d542079.jpeg#pic_center)
### 求解代码

```java
public ListNode removeNthFromEnd (ListNode head, int n) {

        if (head == null || n <= 0) {
            return head;
        }
        // 虚拟头节点：解决删除头节点时无前驱的边界问题
        ListNode dummy = new ListNode(-1);
        dummy.next = head;

        ListNode pre = dummy;
        ListNode fast = head;
        ListNode slow = head;

        // 快指针先单独移动n步
        for (int i = 0; i < n; i++) {
            // 若fast已为null，说明n>链表长度，无节点可删，直接返回原链表
            if (fast == null) {
                return dummy.next;
            }
            fast = fast.next;
        }

        // 快慢指针同步移动，直到快指针到链表末尾（fast=null）
        while (fast != null) {
            fast = fast.next;   // 快指针先后移
            pre = slow;         // 把pre更新为当前的slow（此时slow还没动，pre"记住"了slow现在的位置）
            slow = slow.next;   // slow再后移（此时pre已经是slow移动后的上一个节点）
        }

        // 执行删除操作：让前驱节点的next跳过slow，指向slow的下一个节点
        pre.next = slow.next;

        // 返回新链表头
        return dummy.next;
    }
```

