---
title: "IDEA2023中新建Spring-Boot2.X版本的工程的方法"
date: 2025-12-30 09:40:44
categories:
- 八股
tags:
  - Java
draft: false
---

因为官方 Spring Initializr 服务（start.spring.io）已停止对 Spring Boot 2.x 系列旧版本的支持，仅保留 3.5.0 及以上新版本的分发，因此无法通过该服务获取 2.x 版本的项目模板。
![在这里插入图片描述](/images/dcfa7a57624b4c05af96659f073adc81-9839bdc2.png)

并且Spring Boot 3.x 强制要求 Java ≥17，只有 2.x 系列支持 Java 8，所以会导致下拉框选不到Java8。

![在这里插入图片描述](/images/7cf215e5acee4eabb045bf5323b76c0f-b441c231.png)
为了解决这个问题，需要将在IDEA 的 Spring Initializr 界面，点击顶部「Server URL」输入框，删除原有地址，输入阿里云的服务地址：

```bash
https://start.aliyun.com
```
之后就能够选择Java 8了。

![在这里插入图片描述](/images/1417c26821a54423b00709d290e1de38-6e9dc066.png)
点击Next之后，也能够选择2.X 系列的Spring Boot版本。
![在这里插入图片描述](/images/694c23ce00a0423cb6d399832a0d73ba-538946dc.png)

