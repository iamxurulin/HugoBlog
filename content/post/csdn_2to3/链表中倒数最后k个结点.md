---
title: "链表中倒数最后k个结点"
date: 2026-01-08 19:30:40
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/d3180ca1ff56471dbccdda3b9ab44f82.jpeg#pic_center)
### 求解代码

```java
public ListNode FindKthToTail (ListNode pHead, int k) {
    // 快慢指针开始都指向链表头节点
    ListNode fast = pHead;
    ListNode slow = pHead;

    // 快指针先向前移动 k 步
    for(int i=0;i<k;i++){
        if(fast!=null){
            fast=fast.next;
        }else{
            // 若快指针提前到末尾（说明k > 链表长度），直接返回null
            return null;
        }
    }

    // 快慢指针同步向后移动，直到快指针指向null
    while(fast!=null){
        fast=fast.next;
        slow=slow.next;
    }

    // 慢指针正好指向倒数第k个节点
    return slow;
}
```
为什么可以这么做呢？

这里说明一下：

假设啊，链表总长度是n，fast指针先移动k步后，剩下的没有走的长度就是n-k；

之后，fast和slow指针同步移动，

当fast指针走完剩下的n-k步到达末尾时，

slow指针也恰好走了n-k步，

而这个位置正好就是倒数第k个节点的位置。


