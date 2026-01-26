---
title: "MyBatis Flex和MyBatis Plus的区别"
date: 2026-01-22 15:00:00
categories:
  - 八股
tags:
  - 数据库
draft: false
---


MyBatis Flex和MyBatis Plus都是对原生MyBatis 框架的增强工具，都能够**简化数据库的操作**、**提高开发效率。**



两者在设计理念和功能侧重点上有以下区别：

1.MyBatis Flex除了MyBatis自身，没有任何第三方依赖，极致轻量化；而MyBatis Plus整合的功能更多（如逻辑删除、乐观锁、代码生成等），依赖也更复杂。

2.MyBatis Flex从架构上进行了优化，在SQL执行的过程中没有SQL解析环节和MyBatis拦截器，通过 AST抽象语法树构建SQL，执行链路更短，可以带来更高的性能。而MyBatis Plus大量依赖MyBatis拦截器解析SQL，执行链路更长，有一定解析开销。

3.MyBatis Flex原生支持多表关联查询，无需手写SQL，适合处理复杂的业务场景；而MyBatis Plus在多表查询时需要依赖第三方插件或者手写SQL来实现。
