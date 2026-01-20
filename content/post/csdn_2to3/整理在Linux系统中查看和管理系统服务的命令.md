---
title: "整理在Linux系统中查看和管理系统服务的命令"
date: 2026-01-14 16:46:44
categories:
- 八股
tags:
- Linux
draft: false
---

在Linux系统中，可以使用`systemctl`命令来查看和管理系统服务。

| `systemctl list-units --type=service`|查看所有服务的状态  |
|--|--|
|`systemctl status <服务名>`  | 查看特定服务的状态 |
| `systemctl start <服务名>` | 启动服务 |
| `systemctl stop <服务名>` | 停止服务 |
| `systemctl restart <服务名>` | 重启服务 |
| `systemctl enable <服务名>` |  启用服务，设置为开机自启|
|`systemctl disable <服务名>`  |  禁用服务，取消开机自启|

Linux 中服务名通常都是带`.service`后缀的（如nginx.service、redis-server.service），使用systemctl时省略`.service` 后缀，命令仍会生效。
