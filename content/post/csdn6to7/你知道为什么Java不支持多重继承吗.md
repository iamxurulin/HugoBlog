---
title: "你知道为什么Java不支持多重继承吗"
date: 2025-12-26 14:20:22
categories:
- 八股
tags:
  - Java
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/9b14b83fe0e24089b516cdb7a2327178.png)
看看这张图，B和C都继承了A，D又继承了B和C。

想象这样一种场景，如果此时需要调用D中的一个定义在A的方法，但是呢，这个方法在B和C中存在不同的实现，这个时候就会出现歧义，从而无法抉择应该调用哪个。



