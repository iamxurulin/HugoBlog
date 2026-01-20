---
title: "说说Linux CFS"
date: 2026-01-03 15:53:48
categories:
- 八股
tags:
- Linux
draft: false
---

Linux CFS（ Completely Fair Scheduler，全公平调度器 ）是一种用于替代O(1)调度器的进程调度算法。

CFS主要目的是使每个任务都能够按照其优先级，占用CPU的时间片段，尽可能公平地分配CPU资源。

CFS有以下特点：

1.每个任务都是按照**优先级**决定权重，进而根据权重分配CPU时间，尽量保证每个任务都能按比例公平地获得CPU资源。

2.使用**虚拟运行时间**（vruntime）来衡量每个任务的CPU时间，vruntime越低，优先级越高。

3.所有可运行的任务都存储在**红黑树**中，按照vruntime进行排序，其中最左节点也就是vruntime最小的节点更优先获得CPU的调度。

4.CFS支持多核调度，能够很好地处理从**嵌入式系统**到**服务器集群**的各种应用场景。
