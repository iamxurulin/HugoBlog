---
title: "什么是Spring-Bean"
date: 2026-01-19 15:50:02
categories:
- 八股
tags:
  - Java
draft: false
---

任何通过`Spring` 容器**实例化**、**组装**和**管理**的Java对象都能称之为**Spring Bean**。

`Bean`可以看成是`Spring`应用中的一个普通**Java对象**，这个对象的创建、属性赋值、初始化、销毁等完整的生命周期是由`Spring IOC`容器来统一管理的，并非程序员手动控制。

`Spring Bean`的生命周期分为**实例化**、**依赖注入**、**初始化**以及**销毁**这4个固定不可逆的阶段。

当`Spring` 容器启动时，会根据配置文件或者注解，先实例化`Bean`；

之后，`Spring` 容器再通过注解（`@Autowired`）或者`setter`方法将`Bean`的依赖属性注入进来；

依赖注入完成后，如果Bean标注了`@PostConstruct`注解、实现了`InitializingBean`接口或者配置了init-method，Spring就会调用相应的初始化方法，完成Bean的初始化操作。

初始化完成后，Bean就进入到了就绪状态，可以被程序获取和使用了。

如果Bean标注了`@PreDestroy`注解、实现了`DisposableBean`接口或者配置了`destroy-method`，`Spring`会在容器关闭时调用对应的销毁方法，完成`Bean`的资源释放。









