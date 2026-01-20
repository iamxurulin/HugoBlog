---
title: "K个一组翻转链表：一道让人头疼的算法题"
date: 2025-10-15 20:51:43
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/f70b0c71aae544a88d99dce73574afc6.png#pic_center)
这道题的难点不在于算法本身，而在于细节处理。

### 代码逻辑

#### 1.定位组的结束节点

从起始节点s开始，往后走k-1步，找到当前组的最后一个节点。如果中途遇到null，说明不足k个节点。

```java
public static ListNode teamEnd(ListNode s, int k) {
    while (--k != 0 && s != null) {
        s = s.next;
    }
    return s;
}
```
#### 2.翻转一组节点
提前保存e.next，这样翻转完成后，原来的起始节点s可以直接连接到下一组。
```java
public static void reverse(ListNode s, ListNode e) {
    e = e.next;  // 先保存下一组的起始节点
    ListNode pre = null, cur = s, next = null;
    while (cur != e) {
        next = cur.next;
        cur.next = pre;
        pre = cur;
        cur = next;
    }
    s.next = e;  // 翻转后，原来的起始节点要连接到下一组
}
```

#### 3.主函数

```java
public static ListNode reverseKGroup(ListNode head, int k) {
    ListNode start = head;
    ListNode end = teamEnd(start, k);
    if (end == null) {
        return head;  // 第一组不足k个，直接返回
    }
    
    // 第一组特殊处理：需要更新头节点
    head = end;
    reverse(start, end);
    ListNode lastTeamEnd = start;  // 翻转后start变成了上一组的尾节点
    
    // 处理后续各组
    while (lastTeamEnd.next != null) {
        start = lastTeamEnd.next;
        end = teamEnd(start, k);
        if (end == null) {
            return head;  // 当前组不足k个，保持原样
        }
        reverse(start, end);
        lastTeamEnd.next = end;  // 连接上一组和当前组
        lastTeamEnd = start;     // 更新上一组的尾节点
    }
    return head;
}
```

**完整代码**

```java
public static ListNode reverseKGroup(ListNode head, int k) {
		ListNode start = head;
		ListNode end = teamEnd(start, k);
		if (end == null) {
			return head;  // 第一组不足k个，直接返回
		}

		// 第一组特殊处理：需要更新头节点
		head = end;
		reverse(start, end);
		ListNode lastTeamEnd = start;  // 翻转后start变成了上一组的尾节点

		// 处理后续各组
		while (lastTeamEnd.next != null) {
			start = lastTeamEnd.next;
			end = teamEnd(start, k);
			if (end == null) {
				return head;  // 当前组不足k个，保持原样
			}
			reverse(start, end);
			lastTeamEnd.next = end;  // 连接上一组和当前组
			lastTeamEnd = start;     // 更新上一组的尾节点
		}
		return head;
	}


	//定位组的结束节点
	public static ListNode teamEnd(ListNode s, int k){
		while(--k!=0&&s!=null){
			s=s.next;
		}
		return s;
	}

	public static void reverse(ListNode s, ListNode e) {
		e = e.next;  // 先保存下一组的起始节点
		ListNode pre = null, cur = s, next = null;
		while (cur != e) {
			next = cur.next;
			cur.next = pre;
			pre = cur;
			cur = next;
		}
		s.next = e;  // 翻转后，原来的起始节点要连接到下一组
	}
```

