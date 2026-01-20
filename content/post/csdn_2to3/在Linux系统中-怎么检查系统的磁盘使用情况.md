---
title: "在Linux系统中-怎么检查系统的磁盘使用情况"
date: 2026-01-09 15:15:00
categories:
- 八股
tags:
- Linux
draft: false
---

检查系统的磁盘使用情况可以使用`df`和`du`这两个命令。

### df命令

df（disk filesystem），用于查看磁盘文件系统的整体使用情况。

```bash
df -h
```

h表示human-readable，就是以人类可读的格式输出磁盘分区、已用空间、空闲空间、总空间和挂载点的信息。


### du命令

du（disk usage），用于检查指定目录及其子目录的磁盘使用情况。


```bash
du -sh /home/user
```

-s显示目录的总大小，-h以人类可读的格式显示，合起来就是以人类可读的格式查看home/user目录的总大小。


```bash
du -a
```

显示目录和所有文件的大小。



