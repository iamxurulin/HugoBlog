---
title: "JVM由哪些部分组成"
date: 2026-01-07 16:43:37
categories:
- 八股
tags:
  - Java
draft: false
---

JVM主要由**类加载子系统**（ClassLoader）、**运行时数据区**（Runtime Data Area）、**执行引擎**（Execution Engine）以及**本地方法接口**（Native Interface）4个部分组成。

JVM就像一个虚拟的“电脑”，能让Java程序在不同的操作系统上跑起来。

核心工作流程是：

编写好的Java代码在编译成class文件之后，

类加载器首先负责把class文件从磁盘或者网络中拉进来，放入到内存中；

运行时数据区主要用于存放代码和变量；

执行引擎像个翻译官，把Java的字节码转成机器码；

当需要调用C++之类的外部代码时，就通过本地方法接口来帮忙桥接。

