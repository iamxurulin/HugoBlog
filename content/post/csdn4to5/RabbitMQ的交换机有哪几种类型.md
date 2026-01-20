---
title: "RabbitMQ的交换机有哪几种类型"
date: 2026-01-06 17:52:56
categories:
- 八股
tags:
  - 消息队列
draft: false
---

RabbitMQ是一个可实现异步通信和任务解耦的消息队列系统。

主要有Direct、Fanout、Topic、Headers这4种类型。

|  Direct| 根据消息的routing key精确匹配binding key，只有完全匹配的消息才会被转发到对应的Queue |适合像日志系统这种需要精确匹配的场景|
|--|--|--|
| Fanout |不考虑routing key，直接将接收到的每一条消息都广播到所有绑定到它的Queue  |适合广播消息，比如社交媒体的消息推送|
| Topic |根据消息的routing key和binding key的模式匹配决定消息的流转路径  |适合需要根据特定模式进行消息路由的场景，比如订单系统|
|Headers  |根据消息的头部属性来路由，提供更加复杂和灵活的路由策略  |适合需要更复杂路由逻辑的场景，比如不同部门处理的邮件系统|
