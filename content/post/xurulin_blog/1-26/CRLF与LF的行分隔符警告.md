---
title: "CRLF与LF的行分隔符警告⚠️"
date: 2026-01-26 16:20:07
categories:
  - 项目
tags:
  - Git
draft: false
---

在IDEA开发环境中，点击提交出现以下警告：
![](/images/8553e99abef1ed10456168bc69f62d77-847631fb.png)  
+ CR：Carriage Return（回车）
+ LF：Line Feed（换行）

因为在Windows 系统中默认使用 CRLF（回车+换行）作为一行的结束，但是，在Linux/Mac 系统/Git 内部，默认使用 LF（仅换行）作为一行的结束。

这个警告的意思是当前的文件里包含 Windows 风格的换行符 (CRLF)。

而Git 的标准规范建议：

在仓库（服务器）里统一保存为 LF 格式，以保证不管是谁（用 Windows 还是 Mac 的同事）拉取代码都能正常工作。

如果点击“修复并提交”，则会执行命令：

```bash
git config --global core.autocrlf true
```

这样的话，提交时会自动把本地的 CRLF 转换成 LF 存入仓库，保持仓库的纯净。  
在拉取时，会自动把仓库里的 LF 转换回 CRLF 给 Windows 系统用，保证在本地看代码不会出现乱码。


