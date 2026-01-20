---
title: "什么时候@Async会失效"
date: 2026-01-01 14:12:06
categories:
- 八股
tags:
  - Java
draft: false
---

有多种原因可造成@Async失效：

1.@Async依赖于Spring AOP，如果是内部调用的话则会绕过代理对象，直接调用原始方法。

2.Spring AOP默认只会对public方法生效，对于非public方法则不会被代理，所以此时@Async是失效的。

3.如果Spring Boot的主类或者配置类上没有添加@EnableAsync注解，也就是没有显示启用异步功能，则Spring是不会为其生成代理的。

4.@Async依赖于Spring容器管理的Bean，如果是手动new的对象，并没有被Spring管理，则代理机制也是会失效的。
