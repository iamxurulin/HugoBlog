---
title: "Spring-Boot-2.x和1.x版本相比有哪些区别与改进"
date: 2026-01-02 15:02:23
categories:
- 八股
tags:
  - Java
draft: false
---

昨天说了[Spring Boot 3.x和2.x版本相比有哪些区别与改进？](https://blog.csdn.net/qq_44678890/article/details/156487266?spm=1001.2014.3001.5502)，今天来看看Spring Boot 2.x和1.x版本相比有哪些区别与改进？

1.Spring Boot 1.x基于Spring Framework 4.x，不支持响应式编程；Spring Boot 2.x基于Spring Boot 5，引入了对**响应式编程**的支持。

2.Spring Boot 2.x对Tomcat、Jetty这些嵌入式Web容器的默认版本进行了**升级**，带来了对新HTTP标准的支持。

3.Spring Boot 2.x对底层组件和框架本身做了大量的**性能优化**，使得应用启动时间更短，运行性能更高，更加适合云原生应用和大规模的微服务架构。

4.Spring Boot 1.x中，**Actuator端点**是默认全部开启的，存在安全上的隐患，Spring Boot 2.x对Actuator进行了全面改进，在默认情况下，大多数端点是关闭的，开发者可以通过配置显示地启动需要的端点。


