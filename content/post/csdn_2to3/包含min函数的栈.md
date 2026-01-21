---
title: "包含min函数的栈"
date: 2026-01-15 20:04:19
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](/images/554288af488b497f8f7aa09c9e4e9996-a2093995.jpeg)
### 求解代码

```java
Stack<Integer> stackData1 = new Stack<Integer>();
    Stack<Integer> stackData2 = new Stack<Integer>();


    public void push(int node) {
        stackData1.push(node);
        if(stackData2.isEmpty()||node<=min()){
            stackData2.push(node);
        }
    }
    
    public void pop() {
        if(stackData1.peek().equals(min())){
            stackData2.pop();
        }
        stackData1.pop();
    }
    
    public int top() {
        return stackData1.peek();
    }
    
    public int min() {
        return stackData2.peek();
    }
```

### 小贴士
用 `stackData1.peek().equals(min())` 来比较包装类的实际数值，也可以用 `stackData1.peek().intValue() == min()`，效果是一样的。

