---
title: "链表中的节点每k个一组翻转"
date: 2026-01-07 17:40:08
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/2655cb8961e143bea389d9e776ddd4a9.jpeg#pic_center)
### 代码求解

要实现每k个一组翻转链表，我们先来手撕一下反转整个链表：

```java
//反转以a为头节点的链表
	ListNode reverse(ListNode a){
		ListNode pre = null;
		ListNode cur = a;
		ListNode next = a;
		while(cur!=null){
			next = cur.next;
			cur.next = pre;
			pre = cur;
			cur = next;
		}
		return pre;
	}
```
我们再来手撕一下**反转a到b之间的节点**：

**注意是左闭右开区间**。
```java
//反转区间[a,b)的节点
	ListNode reverse(ListNode a,ListNode b){
		ListNode pre = null;
		ListNode cur = a;
		ListNode next = a;
		while(cur!=b){
			next = cur.next;
			cur.next = pre;
			pre = cur;
			cur = next;
		}
		return pre;
	}
```
所以，实现每k个一组反转就是：

```java
ListNode reverseKGroup(ListNode head,int k){
		if(head == null){
			return null;
		}

		ListNode a = head;
		ListNode b = head;

		for(int i=0;i<k;i++){
			if(b==null){
				return head;
			}
			b=b.next;
		}
		//反转[a,b)区间的链表，得到新的头节点
		ListNode newHead = reverse(a,b);
		//递归处理剩余区间，拼接链表
		a.next = reverseKGroup(b,k);
		return newHead;
	}


	ListNode reverse(ListNode a,ListNode b){
		ListNode pre = null;
		ListNode cur = a;
		ListNode next = a;
		
		while(cur!=b){
			next = cur.next;
			cur.next = pre;
			pre = cur;
			cur = next;
		}

		return pre;
	}
```

