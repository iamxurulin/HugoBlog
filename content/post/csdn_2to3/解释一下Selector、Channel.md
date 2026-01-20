---
title: "解释一下Selector、Channel"
date: 2026-01-09 14:15:00
categories:
- AI
tags:
  - 大模型
draft: false
---

### Selector
Selector是Java Non-blocking  I/O中用于实现I/O多路复用的组件。

Selector有4种事件类型，分别是：

|OP_READ|表示通道中有数据可读  |
|--|--|
| OP_WRITE |表示可以向通道中写入数据  |
| OP_CONNECT |表示通道完成连接操作  |
| OP_ACCEPT | 表示通道可以接受新的连接 |

Selector的作用有两个：

一个是通过一个Selector实例，程序可以同时监听多个通道的I/O事件。

另一个是Selector通常与非阻塞通道配合使用，可以实现高效地非阻塞I/O操作。

### Channel

Channel是Java Non-blocking  I/O中的一个核心概念，主要用于数据的读写操作。

Channel有四种类型：

|SocketChannel| 用于基于TCP的网络通信，可以与服务器或者客户端进行连接 |
|--|--|
|  ServerSocketChannel|仅用于TCP服务端， 用于监听TCP连接 |
|  DatagramChannel|用于基于UDP的网络通信  |
| FileChannel |用于从文件中读取或者向文件中写入数据  |

Channel是双向的，可以同时支持读取和写入。

传统的流要么是输入流，要么是输出流，只能是单向的。

因此，Channel比传统的I/O流更灵活和高效。

Channel可以结合Selector实现多路复用，从而处理多个并发连接。

