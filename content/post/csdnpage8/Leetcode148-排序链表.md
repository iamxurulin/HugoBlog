---
title: "Leetcode148-排序链表"
date: 2025-10-19 12:12:33
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/70cffeca12ed44e1a5110bb1d4e1ee27.png#pic_center)
本文采用自底向上的归并排序来实现。
### 代码逻辑
#### 1. findEnd函数

用于找到从某个节点开始，往后数k个节点的位置。

```java
public static ListNode findEnd(ListNode s, int k) {
    while (s.next != null && --k != 0) {
        s = s.next;
    }
    return s;
}
```
#### 2. merge函数

将两个有序部分合并成一个有序链表。

```java
public static void merge(ListNode l1, ListNode r1, ListNode l2, ListNode r2) {
    ListNode pre;
    
    if (l1.val <= l2.val) {
        start = l1;
        pre = l1;
        l1 = l1.next;
    } else {
        start = l2;
        pre = l2;
        l2 = l2.next;
    }
    
    while (l1 != null && l2 != null) {
        if (l1.val <= l2.val) {
            pre.next = l1;
            pre = l1;
            l1 = l1.next;
        } else {
            pre.next = l2;
            pre = l2;
            l2 = l2.next;
        }
    }
    
    if (l1 != null) {
        pre.next = l1;
        end = r1;
    } else {
        pre.next = l2;
        end = r2;
    }
}
```

#### 3. 处理流程

**第一组的处理**

```java
l1 = head;
r1 = findEnd(l1, step);
l2 = r1.next;
r2 = findEnd(l2, step);
next = r2.next;

r1.next = null;
r2.next = null;

merge(l1, r1, l2, r2);
head = start; 
lastTeamEnd = end;
```

**后续组的处理**

```java
while (next != null) {
    l1 = next;
    r1 = findEnd(l1, step);
    l2 = r1.next;
    
    if (l2 == null) {
        lastTeamEnd.next = l1;
        break;
    }
    
    r2 = findEnd(l2, step);
    next = r2.next;
    r1.next = null;
    r2.next = null;
    
    merge(l1, r1, l2, r2);
    lastTeamEnd.next = start;
    lastTeamEnd = end;
}
```

**完整代码**

```java
public static ListNode sortList(ListNode head) {
		// 计算链表长度
		int n = 0;
		ListNode cur = head;
		while (cur != null) {
			n++;
			cur = cur.next;
		}

		ListNode l1, r1, l2, r2, next, lastTeamEnd;
		// 步长从1开始，每次翻倍（1→2→4→...）
		for (int step = 1; step < n; step <<= 1) {
			l1 = head;
			r1 = findEnd(l1, step);
			l2 = r1.next;
			r2 = findEnd(l2, step);
			next = r2.next;
			// 切断链表，确保l1-r1和l2-r2是独立的子链表
			r1.next = null;
			r2.next = null;
			// 合并两个子链表
			merge(l1, r1, l2, r2);
			// 更新头节点（第一次合并后，头可能变）
			head = start;
			lastTeamEnd = end;

			// 处理剩余的子链表
			while (next != null) {
				l1 = next;
				r1 = findEnd(l1, step);
				l2 = r1.next;
				// 如果只剩一个子链表，直接连接
				if (l2 == null) {
					lastTeamEnd.next = l1;
					break;
				}
				r2 = findEnd(l2, step);
				next = r2.next;
				r1.next = null;
				r2.next = null;
				merge(l1, r1, l2, r2);
				// 连接上一组的尾和当前组的头
				lastTeamEnd.next = start;
				lastTeamEnd = end;
			}
		}
		return head;
	}

	public static ListNode findEnd(ListNode s,int k){
		while(s.next!=null&&--k!=0){
			s=s.next;
		}
		return s;
	}

	public static ListNode start; // 合并后的头
	public static ListNode end;   // 合并后的尾

	public static void merge(ListNode l1, ListNode r1, ListNode l2, ListNode r2) {
		ListNode pre;
		// 确定合并后的头节点
		if (l1.val <= l2.val) {
			start = l1;
			pre = l1;
			l1 = l1.next;
		} else {
			start = l2;
			pre = l2;
			l2 = l2.next;
		}

		// 循环比较，合并节点
		while (l1 != null && l2 != null) {
			if (l1.val <= l2.val) {
				pre.next = l1;
				pre = l1;
				l1 = l1.next;
			} else {
				pre.next = l2;
				pre = l2;
				l2 = l2.next;
			}
		}

		// 处理剩余节点，确定合并后的尾
		if (l1 != null) {
			pre.next = l1;
			end = r1; // l1有剩余，尾是r1
		} else {
			pre.next = l2;
			end = r2; // l2有剩余，尾是r2
		}
	}
```

