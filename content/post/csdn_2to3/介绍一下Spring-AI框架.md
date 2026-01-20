---
title: "介绍一下Spring AI框架"
date: 2026-01-11 15:43:59
categories:
- 八股
tags:
- Java
draft: false
---

Spring AI是一个基于Spring生态的**AI应用开发框架**。

通过提供统一的API和抽象，让Java开发者可以不用考虑底层实现的差异，更便捷地接入和使用各种AI大模型及其相关技术。

Spring AI框架的核心特性：

1.为聊天、文本转图像和嵌入模型提供统一的API，支持流式调用和同步，支持访问特定模型的功能。

2.支持OpenAI、微软Azure、Google、Ollama在内的主流AI模型供应商。

3.可以实现将AI模型的输出自动映射到POJO，方便在Java应用中处理。

4.支持与多种主流向量数据库的集成，通过跨向量存储的可移植API。

5.支持模型请求执行客户端定义的函数和工具。

6.提供文档抽取、转换和加载的组件，可用于数据工程和RAG知识库的构建。

7.为AI模型和向量存储提供了自动配置和Starter依赖。

8.提供类似于WebClient和RestClient的流式API，便于与AI模型交互。

9.提供标准化的Prompt模板引擎，支持动态参数填充和模板复用。
