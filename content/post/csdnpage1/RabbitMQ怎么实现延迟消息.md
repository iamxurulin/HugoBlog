---
title: "RabbitMQ怎么实现延迟消息"
date: 2026-01-17 18:19:27
categories:
- 八股
tags:
  - 消息队列
draft: false
---



在RabbitMQ中，实现延迟消息可以通过死信交换机（DLX）+过期时间（TTL）的方案，也可以采用RabbitMQ官方提供的延迟消息插件。

### DLX+TTL。
主要步骤如下：

1.声明并创建普通交换机和普通队列，完成二者的绑定。

2.声明并创建死信交换机和死信队列，也完成二者的绑定。

3.指定当前普通队列的死信要转发到哪个DLX，以及要匹配哪个死信路由键。

4.不给普通队列配置任何的消费者，使普通队列只做消息暂存和过期，不消费。

5.在生产者发送消息时，为消息设置TTL，将消息发送到普通队列和普通交换机。

6当消息在普通队列的存活时间达到TTL后，过期的消息会被自动转发到DLX中，DLX再重新路由到死信队列，从死信队列中发送的消息就是延迟消息。

### rabbitmq_delayed_message_exchange插件
主要步骤：

1.将插件放到RabbitMQ的plugins目录

2.执行rabbitmq-plugins enable rabbitmq_delayed_message_exchange命令启用插件

3.声明一个延迟交换机

4.声明一个普通队列并绑定该延迟交换机

5.生产者在发送消息时，设置消息投x-dlay:延迟时间(ms)
