---
title: "【双指针】删除有序链表中重复的元素-II"
date: 2026-01-09 21:50:41
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/6dc96e68ace04fe8bece9987b985834c.jpeg#pic_center)
### 求解代码

```java
public ListNode deleteDuplicates (ListNode head) {
    // 空链表 或 单节点链表，无重复节点，直接返回
    if(head == null || head.next == null){
        return head;
    }
    // 虚拟头节点
    ListNode dummy = new ListNode(0);
    dummy.next = head;
    ListNode cur = head;   // 游标指针，遍历链表找重复节点
    ListNode pre = dummy;  // 前驱指针，锚定无重复的有效节点
    
    while(cur != null){
        // 找到连续重复节点的最后一个节点
        while(cur.next != null && cur.val == cur.next.val){
            cur = cur.next;
        }
        
        if(pre.next == cur){
            pre = pre.next; // 从 pre 到 cur，中间没有跳过节点
        }else{
            pre.next = cur.next; // 从 pre 到 cur，中间跳过了节点
        }
        cur = cur.next; // 游标指针后移，继续遍历
    }
    // 返回新链表的有效头节点
    return dummy.next;
}

```
**说明：**

pre是永远站在「已经确认无重复的最后一个节点」的位置。


