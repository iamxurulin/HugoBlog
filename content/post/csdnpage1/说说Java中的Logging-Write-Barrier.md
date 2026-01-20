---
title: "说说Java中的Logging Write Barrier"
date: 2026-01-17 18:17:05
categories:
- 八股
tags:
- Java
draft: false
---


Write Barrier可以理解为JVM在对象引用赋值操作中插入的一段AOP代码，通过这段代码，在应用程序运行期间，垃圾收集器可以感知到对象引用关系的变化，从而维护记忆集（RSet）、卡表（Card Table）等必要的数据结构，避免全堆扫描。

Write Barrier按时机分，有Pre-Write Barrier和Post-Write Barrier两种类型。

Pre-Write Barrier在对象引用改变前触发，用于记录引用变更前的状态；

Post-Write Barrier和Pre-Write Barrier相反，是在对象引用改变后触发，用于记录引用变更后的状态。

Logging是一种策略，在G1收集器中，Post和Pre Write Barrier都采用了Logging机制来实现，也就是先记录日志，后异步处理。

那为什么要用`Logging`这样一种策略呢？

主要是如果每次引用修改都直接去更新RSet这种复杂的全局数据结构，这样会严重**拖慢应用线程**，并可能会导致多线程下的**伪共享问题**。

如果采用`Logging`机制，将对象的引用变更记录丢给**应用线程负责**，让**后台线程负责**复杂的处理，使对象的引用变更记录和处理解耦，从而保证在GC正确的前提下，最大程度地**减少对应用程序吞吐量的影响**。


