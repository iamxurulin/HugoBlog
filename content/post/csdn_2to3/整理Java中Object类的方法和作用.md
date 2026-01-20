---
title: "整理Java中Object类的方法和作用"
date: 2026-01-10 15:47:23
categories:
- 八股
tags:
  - Java
draft: false
---


| public boolean equals(Object obj) |用来比较两个对象是不是相等，默认比较的是内存地址。  |
|--|--|
|public int hashCode()  |  返回当前对象的哈希值|
| public String toString() | 返回对象的字符串形式 |
|public final Class<?> getClass()  | 返回对象运行时的类信息，反射的时候经常用到 |
| public void notify() | 唤醒一个正在等待当前对象的线程。必须在synchronized代码块中配合wait()一起使用 |
| public void notifyAll() | 唤醒所有在这个对象上等待的线程 |
| public void wait() | 当前线程挂起，等待别的线程来notify它，只能在同步块/同步方法中使用 |
|public void wait(long timeout)  | 在wait方法的基础上加了个超时控制，过了时间就自己醒来 |
|public void wait(long timeout,int nanos)  | 在wait()方法的基础上加了个更精细的超时控制，支持纳秒级的等待 |
|protected Object clone()  |拷贝当前对象，默认是浅拷贝  |
| protected void finalize() |  对象被垃圾回收之前会自动调用这个方法|



