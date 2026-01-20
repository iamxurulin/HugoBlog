---
title: "Spring Boot 3.x和2.x版本相比有哪些区别与改进？"
date: 2026-01-01 16:05:33
categories:
- 八股
tags:
- 八股
draft: false
---

1.Spring Boot 2.x基于Java EE，而Spring Boot 3.x迁移到了Jakartaa EE，一些核心的包名也从`javax.*`变更为`jakarta.*`了。

2.Spring Boot 2.x支持JDK8、11和17版本，而Spring Boot 3.x要求JDK版本最低为17。

3.Spring Boot 2.x 没有原生编译的内置支持，Spring Boot3.x则提供了对GraalVM Native Image的开箱即用支持，可以将Spring应用编译成本地的可执行文件。

4.Spring Boot 2.x仅支持基本的监控和追踪，Spring Boot 3.x引入了更完善的分布式追踪、日志关联和性能指标收集，支持OpenTelemetry标准，开发者可以借助Observability更好地监控和分析应用的运行状况。

5.Spring Boot 2.x支持Spring Security 5，在安全性上存在一定的局限性；Spring Boot 3.x增强了对Spring Security 6的支持，强化了身份认证、授权和安全配置的能力。

6.Spring Boot 2.x的依赖库和自动配置很强大，但是存在一些历史遗留的依赖和配置；Spring Boot 3.x对内部依赖进行了一些模块化的调整，对一些不再使用或者过时的库进行了清理。


