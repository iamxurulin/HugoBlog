---
title: "单指针-删除有序链表中重复的元素-I"
date: 2026-01-09 21:14:50
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](/images/86010b83f2a64a51ba6dff8a4c931ccb-ec7be3de.jpeg)
### 求解代码

```java
	public ListNode deleteDuplicates (ListNode head) {
    // 空链表 或 单节点链表，无重复节点，直接返回
    if(head == null || head.next == null){
        return head;
    }
    // 定义游标指针，从链表头节点开始遍历
    ListNode cur = head;
    // 遍历链表，直到当前节点是最后一个节点
    while(cur.next != null){
        // 当前节点和下一个节点值相等，删除下一个重复节点
        if(cur.val == cur.next.val){
            cur.next = cur.next.next;
        }else{
            // 值不相等，指针正常后移
            cur = cur.next;
        }
    }
    // 返回原链表头节点
    return head;
}
```

