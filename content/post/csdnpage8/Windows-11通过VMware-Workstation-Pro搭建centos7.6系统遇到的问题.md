---
title: "Windows-11通过VMware-Workstation-Pro搭建centos7.6系统遇到的问题"
date: 2025-09-07 23:11:14
categories:
- 项目
tags:
- Linux
draft: false
---

首先，电脑的配置是Windows 11 专业版+VMware Workstation Pro 15.5.
### 1.因为开启了Hyper -V，所以会出现如下问题：

![在这里插入图片描述](/images/1d4a490dde974e4887869fc17eed7a26-6290f395.png)
![在这里插入图片描述](/images/cf63d9eb6b4341dda230c3fd0dc302e5-20ffa8e3.png)
根据网上查找到的一些解决方案，将Hyper -V和Device Guard这些禁用掉，以为可以解决这个问题，然而。。。。。。
出现如下问题2.。
### 2.Your device ran into a problem and needs to restart. We're just collecting some error info, and then you can restart.

这个问题直白一点就是蓝屏，但是不知道为什么此时显示黑屏。。。。

于是，我感觉是Windows 11 又更新或者删除了什么东西导致了这些所谓的乱七八糟的问题。

多次尝试网上的解决方案之后仍然没有解决该问题。

当事人十分后悔前几天把电脑更新到了Windows 11，于是决定重新装回稳定一点的Windows 10，但是，等等，重装系统之后又要重新装软件，太麻烦了。

灵机一动，将这个问题喂给豆包，得到的回复中有一条是：“旧版本（如 VMware Workstation Pro 15 及以下）对 Windows 11 兼容性较差，可能触发蓝屏。”


于是，赶紧把VMware Workstation Pro 15.5给卸载了，重新装了个17.6，你猜怎么着？

没错，问题解决了。





