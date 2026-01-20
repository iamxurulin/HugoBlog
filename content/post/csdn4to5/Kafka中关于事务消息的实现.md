---
title: "Kafka中关于事务消息的实现"
date: 2025-12-29 15:06:48
categories:
- 八股
tags:
- 消息队列
draft: false
---

Kafka的事务消息实现了消息在生产、传输和消费的过程中的“仅一次”传递，也就是所谓的Exactly Once语义。

Kafka的事务消息主要由**事务协调器**、**幂等生产者**和**事务性消费**这三个核心组件来实现。

事务协调器主要负责事务的启动、提交和终止管理，将事务状态记录到__transaction_state内部的主题；

为了确保同一事务的每条消息只写入一次，Kafka Producer通过Producer ID来作为事务的唯一性标志。

在消费的过程中，消费者可以选择只消费已提交的事务消息，从而确保数据的最终一致性。

我们可以理一下Kafka的事务消息流程：

首先是生产者向Transaction Coordinator**请求**启动事务；

接下来生产者为了保证幂等性，给每条消息都带上唯一的Producer ID和Sequence Number，**开始向Kafka写入事务消息**；

当所有消息都写入完成后，生产者开始向事务协调去发送commit或者abort请求提交或者终止事务。

最后，消费者为了实现最终的数据一致性，可以通过设置read_commited 隔离级别，**只消费已提交的消息**。






