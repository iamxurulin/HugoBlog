---
title: "Spring-AI怎么实现结构化输出"
date: 2026-01-12 16:12:09
categories:
- 八股
tags:
  - Java
draft: false
---

结构化输出是将大语言模型返回的自由文本输出转换为预定义的**数据格式**。

Spring AI是通过`StructuredOutputConverter`机制来实现**结构化输出**的：

1.`StructuredOutputConverter`实现了`FormatProvider`接口，这个接口提供特定的格式指令给AI模型，这些指令附加到用户的提示词后面，明确地告诉模型应该生成何种结构的输出。

2.`StructuredOutputConverter` 实现了Spring的`Converter<String, T>`接口，这个接口负责将大模型返回的文本输出转换为开发者指定的目标类型。

Spring AI提供了多种内置的转换器实现：

`BeanOutputConverter`：转换为自定义Java实体类，在开发中最常用；

`MapOutputConverter`：转换为松散的Map键值对结构；

`ListOutputConverter`：转换为指定类型的集合结构。


