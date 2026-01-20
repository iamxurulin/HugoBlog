---
title: "怎么实现AI的多轮对话功能？"
date: 2026-01-13 15:49:02
categories:
- AI
tags:
- 大模型
draft: false
---

要实现AI的多轮对话功能，关键在于让AI能够记住与用户之前的对话内容并保持上下文的连贯。

可以使用Spring AI框架提供的**对话记忆**和**Adviso**r特性来实现这个功能。

主要是通过构造`ChatClient`来实现功能更丰富、更灵活的AI对话。

ChatClient可以看成是一系列可插拔的拦截器，在调用AI前后执行一些额外的操作。

MessageChatMemoryAdvisor是实现多轮对话的关键Advisor，其主要作用就是从对话记忆中检索历史对话，然后将对话历史作为消息集合添加到当前的提示词中，这样的话，AI模型就可以记住之前进行过的交流。

ChatMemory接口中定义了**保存消息**、**查询消息**和**清空历史**的方法，MessageChatMemoryAdvisor也依赖于这个接口的实现来**存取对话历史**。

为了解决对话记忆仅存在于内存中，在服务重启之后会造成记忆丢失的问题，需要考虑将对话记忆进行**持久化**。

由于spring-ai-starter-model-chat-memory-jdbc的依赖版本较少，可以考虑自定义ChatMemory接口的方式实现：

开发一个实现了ChatMemory接口的FileBasedChatMemory类，再使用高性能的**Kryo序列化库**将对话消息序列化后保存到本地文件中，读取的时候再进行反序列化。
