---
title: "说说LangChain的核心架构"
date: 2026-01-10 15:22:25
categories:
- AI
tags:
  - 大模型
draft: false
---

LangChain的核心架构主要由LangChain Libraries、LangChain Templates、LangServe和LangSmith**四个模块**组成。

### **LangChain Libraries**

整个LangChain框架的基础，包含langchain-core、langchain以及langchain-community三个子模块。

其中，langchain-core提供了构建应用所需的核心功能；

langchain是构建链和代理的主要模块；

langchain-community整合了多个第三方库和集成。

### **LangChain Templates**
提供了一系列适用于各种任务的参考架构模板，像问答系统、文档解析和对话管理等常见的任务。

### LangServe
用于将LangChain构建的链部署为REST API的库，支持高并发请求和流式操作，适用于构建生产环境中的API服务。

### LangSmith
这是一个开发者平台，提供调试、测试、评估和监控的功能。





