---
title: "常用的JVM配置参数"
date: 2026-01-05 15:48:48
categories:
- 八股
tags:
- Java
draft: false
---


| -Xms |初始化堆内存大小  |
|--|--|
|-Xmx  |最大堆内存大小  |
| -Xss | 设置每个线程的栈大小 |
| -XX:MetaspaceSize | 初始化元空间大小 |
|  -XX:MaxMetaspaceSize| 最大元空间大小 |
| -XX:+HeapDumpOnOutOfMemoryError | 当发生OOM时，生成堆转储 |
| -XX:+PrintGCDetails | 打印详细的垃圾回收日志 |
|  -XX:+UseG1GC|  启用G1垃圾收集器|
|-XX:+UseConcMarkSweepGC  | 启用CMS垃圾收集器 |
| -XX:+UseZGC | 启用ZGC低延迟垃圾收集器 |

