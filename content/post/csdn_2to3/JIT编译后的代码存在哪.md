---
title: "JIT编译后的代码存在哪"
date: 2026-01-11 16:04:17
categories:
- 八股
tags:
- JVM
draft: false
---

JIT（Just-In-Time）编译后的代码通常存放在代码缓存区（Code Cache）中。

JVM提供了如下参数用于调整Code Cache的大小和行为：

|-XX:InitialCodeCacheSize| 初始大小 |
|--|--|
| -XX:ReservedCodeCacheSize | 最大大小 |
|  -XX:+PrintCodeCache| 打印Code Cache信息 |

Code Cache的默认大小依赖于JVM的版本和运行环境，通常有一个最大值。

Code Cache分为多个区域，分别存储不同级别的编译代码：

|  非方法代码|  存储运行时的JVM调试代码或者模板代码|
|--|--|
| 方法代码 |存储普通JIT编译的代码  |
| 轮廓代码 | 存储优化级别更高的代码 |

