---
title: "An-error-occurred-while-running-a-WSL-command.Please-check-your-WSL-configuration-and-try-again.解决办法"
date: 2025-10-31 22:36:04
categories:
- 项目
tags:
- Code
draft: false
---

安装好Docker启动之后报这个错误：
![在这里插入图片描述](/images/f030e755fc2c428282412b83b82ea615-5bfd61da.jpeg)
有博客说是因为没有启动【虚拟机平台】，于是我Win+r➡【optionalfeatures】，看了一下发现我的【Virtual Machine platform】是启动的，那到底是什么原因呢？

问了一下AI，说这个错误表示 Windows 的 HCS (Host Compute Service) 服务不可用。

执行了以下操作：

```java
# 1. 启用 vmcompute 服务
sc.exe config vmcompute start=auto

# 2. 启动服务
sc.exe start vmcompute

# 3. 启用 vmms
sc.exe config vmms start=auto
sc.exe start vmms

# 4. 关闭 WSL
wsl --shutdown
```
然后重新启动 Docker Desktop，出现这个报错：
![在这里插入图片描述](/images/d5c28c0a71ac4e509ea441f7c61d7c3f-4b4b7bde.png)
这个错误表示虚拟化未启用。但是我打开任务管理器→ 切换到"性能"选项卡 → 点击"CPU"，底部显示 "虚拟化: 已启用"。

接下来尝试查看 Hypervisor 状态，

```java
bcdedit /enum | findstr hypervisorlaunchtype
```
结果显示 off，需要启用一下：

```java
bcdedit /set hypervisorlaunchtype auto
```

重启电脑，然后再启动 Docker Desktop，问题就解决了。
