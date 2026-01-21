---
title: "配置ssh解决https不稳定的问题"
date: 2026-01-13 12:26:04
categories:
- 项目
tags:
- Git
draft: false
---

将本地文件推送到github仓库时会遇到各种各样的问题，比如：

<!-- 这是一张图片，ocr 内容为： -->
![](/images/64fd978473f1f882604b64b66b938fb9-79183cab.png)

 <!-- 这是一张图片，ocr 内容为： -->
![](/images/5019cbd27b7de37ba1b02dde823b5f11-a57ba6db.png)

<!-- 这是一张图片，ocr 内容为： -->
![](/images/ee8bd4a0962c027db3a089bbde691a76-746345af.png)

为了解决这个GitHub 官方都承认的 HTTPS 不稳定问题，可以考虑使用ssh：

### ① 生成 SSH Key（如果以前没配过）
在 **任意目录** 打开命令行窗口，执行：

```bash
ssh-keygen -t ed25519 -C "你的GitHub邮箱"
```

一路 **直接回车 × 3**

成功后会看到类似：

```latex
Your identification has been saved in ...
```

### ② 复制 SSH 公钥（关键）
用windows的文本阅读器打开id_ed25519.pub文件，**复制整行内容**（以 `ssh-ed25519` 开头）

### ③ GitHub 添加 SSH Key
登录 GitHub账户，右上角头像 → Settings→ SSH and GPG keys→ New SSH key

**Title**：任意起一个名字（如 `my-ssh-key`）

**Key**：粘贴刚才复制的内容

### ④ 测试 SSH 是否通
```bash
ssh -T git@github.com
```

第一次会问：

```latex
Are you sure you want to continue connecting (yes/no)?
```

输入：

```latex
yes
```

如果看到：

```latex
Hi iamxurulin! You've successfully authenticated
```

说明 SSH 配置成功

### ⑤接下来把仓库从 HTTPS 切到 SSH
在 `public` 目录执行：

```bash
git remote set-url origin git@github.com:iamxurulin/iamxurulin.github.io.git
```

验证：

```bash
git remote -v
```

可以看到：

```latex
origin  git@github.com:iamxurulin/iamxurulin.github.io.git (fetch)
origin  git@github.com:iamxurulin/iamxurulin.github.io.git (push)
```

### ⑥重新强制推送
```bash
git push -f origin main
```



