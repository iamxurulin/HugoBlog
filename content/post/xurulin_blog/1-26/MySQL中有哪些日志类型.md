---
title: "MySQL中有哪些日志类型？"
date: 2026-01-24 15:38:05
categories:
  - 八股
tags:
  - 数据库
draft: false
---

MySQL有binlog、redo log和undo log三种日志，其中binlog 负责主从复制和数据恢复，redo log保证崩溃后数据不丢失，undo log支撑事务回滚和MVCC。

### 1.binlog

binlog 是server层的日志，记录的是逻辑操作，也就是原始SQL或者行变更前后的值。

它的核心场景是主从同步，从库拉取主库到binlog重放一遍就能保持数据一致。

另外，做数据恢复的时候，也是靠binlog配合全量备份回放到指定时间点。

### 2.redo log是InnoDB引擎独有的，记录的是物理变更，具体就是“某个数据页的某个偏移量改成了什么值”。

它的作用是崩溃恢复（crash-safe），基于WAL（Write Ahead  Log）机制，MySQL挂了重启后，InnoDB会用redo log把没来得及刷盘的脏页恢复出来。

redo log是循环写的，空间固定，写满了就得等checkpoint推进才能继续。

### 3.undo log也是InnoDB引擎的逻辑日志，记录的是数据修改前的旧值。

事务回滚的时候，就靠undo log把数据改回去，另外MVCC的快照读也依赖它，别的事务要读历史版本，顺着undo log链往前找就行。

![](/images/84b73cf3efe84a6a8996ec343e4cf107-b0b792ea.jpeg)
