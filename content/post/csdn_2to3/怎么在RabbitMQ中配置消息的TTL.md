---
title: "怎么在RabbitMQ中配置消息的TTL？"
date: 2026-01-12 14:17:02
categories:
- 八股
tags:
- 消息队列
draft: false
---

TTL（Time To Live）表示**消息在队列中存活的时间**，主要用于防止消息在队列中无限积压，导致系统资源的耗尽。

配置TTL有两种方式，一种是**队列级别的TTL**，另外一种是**消息级别的TTL**。

1.在声明队列时通过设置`x-message-ttl`参数来指定队列中所有消息的TTL。

2.在发送消息时通过`AMQP.BasicProperties`属性指定单个消息的TTL。


