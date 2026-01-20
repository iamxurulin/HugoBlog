---
title: "用堆秒杀「合并 K 个已排序的链表」"
date: 2025-10-06 19:08:27
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/63434de59415440ea0dc5ad147cacf25.png#pic_center)
这道题的思路是用小根堆 “盯紧” 最小节点。

核心步骤如下：

 1. 先把 K 个链表的头节点放进小根堆，这样堆顶就是当前最小节点；
 2.  每次从堆顶取出最小节点，加入结果链表；
 3. 再把这个最小节点的下一个节点放进堆里（如果有的话）； 
 4. 重复步骤 2-3，直到堆为空，所有节点都被合并。

### 1.初始化小根堆
Java 的PriorityQueue默认是小根堆，但这里显式传入比较器(a, b) -> a.val - b.val，确保按节点值升序排序。

```java
PriorityQueue<ListNode> heap = new PriorityQueue<>((a, b) -> a.val - b.val);
```
### 2.加入所有链表的头节点
遍历输入的 K 个链表，把非空的头节点加入堆。

```java
for (ListNode h : arr) {
    if (h != null) {
        heap.add(h);
    }
}
```

### 3. 构建结果链表的头部
先从堆顶取出最小的节点（h），作为结果链表的头节点。

用pre指针跟踪结果链表的尾部。

把h的下一个节点加入堆（如果存在）。

```java
ListNode h = heap.poll();
ListNode pre = h;
if (pre.next != null) {
    heap.add(pre.next);
}
```
### 4.循环合并剩余节点
每次从堆顶取最小节点cur，拼到pre后面，然后pre移到cur。

再把cur的下一个节点加入堆。

```java
while (!heap.isEmpty()) {
    ListNode cur = heap.poll();  
    pre.next = cur;             
    pre = cur;                  
    if (cur.next != null) {
        heap.add(cur.next);      
    }
}
```
**完整代码**

链接：https://pan.quark.cn/s/8a7bb143e196
提取码：dXXp
