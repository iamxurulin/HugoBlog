---
title: "说说Java中的JIT"
date: 2026-01-17 18:18:18
categories:
- 八股
tags:
  - Java
draft: false
---


JIT（Just In Time）**即时编译**，是一种在程序运行时将字节码转换为机器码的技术。

JIT在Java程序运行的时候，如果发现了频繁执行的代码段，我们称之为热点代码，就会将这段热点代码编译成机器码，从而减少解释执行的开销。

JIT有CLient Compiler和Server Compiler两种编译类型，

其中，Client Compiler适用于客户端应用程序，主要用于快速启动的轻量级优化；

Server Compiler适用于服务端应用程序，主要用于长时间运行的重度优化。
