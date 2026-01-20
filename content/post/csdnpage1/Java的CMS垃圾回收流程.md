---
title: "Java的CMS垃圾回收流程"
date: 2026-01-16 17:20:13
categories:
- 八股
tags:
  - Java
draft: false
---




**1.初始标记（initial mark）**

CMS会标记所有根对象直接可达的对象。



**2.并发标记（Concurrent marking）**

并发标记阶段，垃圾收集器和应用程序并发执行，从根对象直接可达的对象开始进行tracing，递归的扫描所有可达对象。



**3.并发预清理（Concurrent precleaning）**

并发预清理阶段会先分担一些重新标记阶段的工作，扫描卡表脏的区域以及新晋升到老年代的对象。



**4.可中断的预清理阶段（AbortablePreclean）**

可中断的预清理阶段也是先分担一些重新标记阶段的工作，和并发预清理阶段不同的是这个阶段可以中断。



**5.重新标记（remark）**

因为前几个并发阶段会导致引用关系发生变化，所有需要重新遍历一遍新生代对象、GC Roots和卡表等，从而对标记进行修正，需要花较长的时间来进行重新扫描。



**6.并发清理（Concurrent Sweeping）**

并发清理阶段，标记为不可达的对象会被清理。



**7.并发重置（Concurrent Reset）**

重置CMS内部的状态。


