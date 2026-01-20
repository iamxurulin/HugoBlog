---
title: "在Linux系统中，如何设置文件的权限和拥有者？"
date: 2026-01-12 16:41:27
categories:
- 八股
tags:
- Linux
draft: false
---

在Linux系统中，文件的权限可以通过`chmod`指令来设置，文件的拥有者可以通过`chown` 指令来设置。

**1.设置文件的权限**

```bash
chmod 755 my_file
```
设置my_file文件的权限为755

**2.设置文件的拥有者**

```bash
chown user:group my_file
```
将文件my_file的拥有者设置为user，所属的组设置为group

在Linux中，文件权限以读（r）、写（w）、执行（x）三个基本权限来表示。

权限分用户（u）、组（g）和其他用户（o）三类。

755表示的是所有者拥有rwx权限，组合其他用户拥有rx权限，没有w权限。

**配置文件**一般设置为644，**脚本文件**设置为755。
