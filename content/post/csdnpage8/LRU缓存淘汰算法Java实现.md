---
title: "LRU缓存淘汰算法Java实现"
date: 2025-10-21 21:52:10
categories:
- 算法
tags:
  - 链表
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/e97d9bdd9fa0407bbc2e587292a523ef.png#pic_center)

LRU的核心思想是当缓存空间满了,优先淘汰最久未被使用的数据。

这种思想其实在生活中也有，比如想象一下你的书桌只能放5本书。每次看完一本书,你就把它放在最右边。当需要放新书但桌面满了时,你会扔掉最左边那本(最久没看的)。这其实就是LRU的思想!


### 代码逻辑
#### 1. addNode

```java
public void addNode(DoubleNode newNode) {
    if (head == null) {
        // 链表为空,新节点既是头也是尾
        head = newNode;
        tail = newNode;
    } else {
        // 追加到尾部
        tail.next = newNode;
        newNode.last = tail;
        tail = newNode;
    }
}
```
#### 2. moveNodeToTail

每次访问一个节点,都要把它移到尾部,表示"最近刚用过"。

```java
public void moveNodeToTail(DoubleNode node) {
    if (tail == node) return;  // 已经在尾部
    
    // 从原位置摘除节点
    if (head == node) {
        head = node.next;
        head.last = null;
    } else {
        node.last.next = node.next;
        node.next.last = node.last;
    }
    
    // 追加到尾部
    node.last = tail;
    node.next = null;
    tail.next = node;
    tail = node;
}
```

#### 3. removeHead

当缓存满了需要淘汰数据时,删除头部(最久未使用的)节点。

```java
public DoubleNode removeHead() {
    if (head == null) return null;
    
    DoubleNode ans = head;
    if (head == tail) {
        // 只有一个节点
        head = null;
        tail = null;
    } else {
        head = ans.next;
        ans.next = null;
        head.last = null;
    }
    return ans;
}
```

#### 4.get - 查询数据

```java
public int get(int key) {
    if (keyNodeMap.containsKey(key)) {
        DoubleNode ans = keyNodeMap.get(key);
        nodeList.moveNodeToTail(ans);  // 标记为最近使用
        return ans.val;
    }
    return -1;
}
```

#### 5.put - 插入或更新数据

```java
public void put(int key, int value) {
    if (keyNodeMap.containsKey(key)) {
        // key已存在,更新value
        DoubleNode node = keyNodeMap.get(key);
        node.val = value;
        nodeList.moveNodeToTail(node);  // 移到尾部
    } else {
        // key不存在,插入新节点
        if (keyNodeMap.size() == capacity) {
            // 缓存已满,先淘汰最久未使用的
            DoubleNode removed = nodeList.removeHead();
            keyNodeMap.remove(removed.key);
        }
        
        DoubleNode newNode = new DoubleNode(key, value);
        keyNodeMap.put(key, newNode);
        nodeList.addNode(newNode);
    }
}
```
**完整代码**

```java
class LRUCache{
		class DoubleNode {
			public int key;      // 键
			public int val;      // 值
			public DoubleNode last;  // 前驱节点
			public DoubleNode next;  // 后继节点
			public DoubleNode(int k, int v) {
				key = k;
				val = v;
			}
		}

		class DoubleList{
			private DoubleNode head;
			private DoubleNode tail;

			public DoubleList(){
				head = null;
				tail = null;
			}

			public void addNode(DoubleNode newNode) {
				if (head == null) {
					// 链表为空,新节点既是头也是尾
					head = newNode;
					tail = newNode;
				} else {
					// 追加到尾部
					tail.next = newNode;
					newNode.last = tail;
					tail = newNode;
				}
			}

			public void moveNodeToTail(DoubleNode node) {
				if (tail == node) return;  // 已经在尾部

				// 第一步: 从原位置摘除节点
				if (head == node) {
					head = node.next;
					head.last = null;
				} else {
					node.last.next = node.next;
					node.next.last = node.last;
				}

				// 第二步: 追加到尾部
				node.last = tail;
				node.next = null;
				tail.next = node;
				tail = node;
			}

			public DoubleNode removeHead() {
				if (head == null) return null;

				DoubleNode ans = head;
				if (head == tail) {
					// 只有一个节点
					head = null;
					tail = null;
				} else {
					head = ans.next;
					ans.next = null;
					head.last = null;
				}
				return ans;
			}
		}

		private HashMap<Integer, DoubleNode> keyNodeMap;
		private DoubleList nodeList;

		private final int capacity;

		public LRUCache(int cap){
			keyNodeMap = new HashMap<>();
			nodeList = new DoubleList();
			capacity = cap;
		}

		public int get(int key) {
			if (keyNodeMap.containsKey(key)) {
				DoubleNode ans = keyNodeMap.get(key);
				nodeList.moveNodeToTail(ans);  // 标记为最近使用
				return ans.val;
			}
			return -1;
		}

		public void put(int key, int value) {
			if (keyNodeMap.containsKey(key)) {
				// key已存在,更新value
				DoubleNode node = keyNodeMap.get(key);
				node.val = value;
				nodeList.moveNodeToTail(node);  // 移到尾部
			} else {
				// key不存在,插入新节点
				if (keyNodeMap.size() == capacity) {
					// 缓存已满,先淘汰最久未使用的
					DoubleNode removed = nodeList.removeHead();
					keyNodeMap.remove(removed.key);
				}
				DoubleNode newNode = new DoubleNode(key, value);
				keyNodeMap.put(key, newNode);
				nodeList.addNode(newNode);
			}
		}

	}

```

**关注我,持续分享算法干货!** 🚀
