---
title: "Spring-Boot支持哪些嵌入Web容器"
date: 2026-01-07 16:27:41
categories:
- 八股
tags:
  - Java
draft: false
---

Spring Boot支持以下4种嵌入Web容器：

1.Tomcat

Spring Boot默认的**嵌入式Web容器**，Spring Boot会自动地将Tomcat内嵌到应用程序中，是一种广泛使用的轻量级、广泛使用的Servlet容器。

2.Jetty

Jetty比Tomcat更轻量，是一个**高效的Web服务器和Servlet容器**，通常用于嵌入式系统或对资源占用较为敏感的环境。

3.undertow

undertow支持异步IO和HTTP/2，是一个轻量级的**高性能Web服务器和Servlet容器**，适用于处理高并发的HTTP请求。

4.Netty

Netty是一个非阻塞的异步事件驱动框架，是Spring WebFlux的默认嵌入式容器，仅适用于响应式编程模型，适合高并发的响应式应用。




