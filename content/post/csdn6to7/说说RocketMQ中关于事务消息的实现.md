---
title: "说说RocketMQ中关于事务消息的实现"
date: 2025-12-26 16:46:06
categories:
- 八股
tags:
  - 消息队列
draft: false
---

在RocketMQ中，为了确保消息与本地事务的**一致性**，生产者会先将消息发送到RocketMQ的Topic中，这个时候消息的状态为半消息，对于消费者来说，还是不可见的。

接下来，生产者会执行本地事务：

如果本地事务**成功**了，生产者就会向RocketMQ执行commit操作，将半消息转变为正式消息，这样消费者就可见了。

如果本地事务**失败**了，生产者就会向RocketMQ执行Rollback操作，然后RocketMQ就会丢弃这个半消息。

如果生产者没有及时地执行commit或者rollback操作，那么RocketMQ就会定时地回查本地事务的状态，从而来决定是否commit或者rollback消息。

