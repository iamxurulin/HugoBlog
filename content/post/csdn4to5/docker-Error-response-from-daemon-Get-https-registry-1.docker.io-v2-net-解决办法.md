---
title: "docker-Error-response-from-daemon-Get-https-registry-1.docker.io-v2-net-解决办法"
date: 2025-12-31 08:38:06
categories:
- 项目
tags:
- Code
draft: false
---

VMware虚拟机中的Ubuntu安装Docker后，输入：

```bash
sudo docker run hello-world
```
测试Docker是否安装成功。

出现以下问题：
![在这里插入图片描述](/images/e82fe1dbc7154fd58ad712873f56edd1-c370fc27.png)

这个错误是因为 Docker 无法连接到 Docker registry 来拉取镜像。

通过更换国内镜像源解决，创建  Docker 配置文件：

```bash
sudo vim /etc/docker/daemon.json
```
添加国内镜像源：

```json
{
  "registry-mirrors": [
    "https://docker.m.daocloud.io",
    "https://dockerproxy.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://docker.nju.edu.cn"
  ]
}
```
重启 Docker:

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```
验证配置:

```bash
# 查看配置是否生效
sudo docker info | grep -A 5 "Registry Mirrors"
```

出现以下信息：

![在这里插入图片描述](/images/f98a1d24d57942af9b140e3d453d3c3c-0aa8bff4.png)
说明配置已经生效了。

最后再测试运行：

```bash
sudo docker run hello-world
```
看到有如下“Hello from Docker!”的输出，表明Docker已经安装成功了，并且可以拉取镜像去执行了。

![在这里插入图片描述](/images/dfba5f5fc36941539cf7228dea393a88-62434559.png)

