---
title: "你知道Spring-Boot配置文件的加载优先级吗"
date: 2026-01-07 15:59:34
categories:
- 八股
tags:
  - Java
draft: false
---

优先级如下：

命令行参数> JAR**包外** 的application-{profile}.properties> JAR **包外**的application.properties>JAR**包内**的application-{profile}.properties>JAR**包内**的application.properties。

需要**注意**的是：

当application.properties和application.yml同时存在时，如果是相同的参数，最终生效的是**application.properties**中的配置。

