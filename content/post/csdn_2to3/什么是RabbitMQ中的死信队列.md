---
title: "什么是RabbitMQ中的死信队列？"
date: 2026-01-12 14:44:12
categories:
- 八股
tags:
- 消息队列
draft: false
---

在消息队列系统中，**死信队列**（Dead Letter Queue,DLQ）是一种处理无法正常消费的消息的**机制**。

RabbitMQ 中实现死信机制的核心是**死信交换机**（Dead Letter Exchange, DLX），绑定该交换机的队列就是**死信队列**。

死信队列是用来接收那些**被拒绝的**、**过期的**或者已经**达到最大传递次数**的消息。

可以通过给队列设置`x-dead-letter-exchange` 参数来指定死信交换机，搭配`x-dead-letter-routing-key`指定死信路由键，从而实现死信队列的绑定。


