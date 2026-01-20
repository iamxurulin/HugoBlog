---
title: "下载 GitHub 仓库「单个文件夹」的方法"
date: 2026-01-15 12:25:31
categories:
- 项目
tags:
- Git
draft: false
---

#### 方法1
1. <font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">打开 GitHub，找到要下载的「目标文件夹」，</font>**<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">点击进入这个文件夹的页面</font>**<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);"></font>
2. <font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">复制浏览器地址栏里的「文件夹完整 URL」（比如：</font>[https://github.com/letere-gzj/live2d-widget-v3/tree/main/Resources](https://github.com/letere-gzj/live2d-widget-v3/tree/main/Resources)<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">）</font>
3. <font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">打开 DownGit 官网：</font><font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);"></font><font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);"> </font>[<font style="color:rgb(0, 87, 255);background-color:rgba(0, 0, 0, 0);">https://minhaskamal.github.io/DownGit/</font>](https://minhaskamal.github.io/DownGit/)
4. <font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">把第2步复制的文件夹 URL 粘贴到 DownGit 的输入框里，点击「</font>**<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">Download</font>**<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">」按钮即可</font>



#### <font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">方法2</font>
可以选择在【桌面】打开命令行窗口：

1.  初始化克隆仓库

```bash
git clone --filter=blob:none --no-checkout https://github.com/用户名/仓库名.git
```

2. 进入克隆的仓库目录

```bash
cd 仓库名
```

3. 开启「稀疏检出」功能，告诉Git：我只需要指定文件夹

```bash
git sparse-checkout init --cone
```

4. 指定要下载的「单个文件夹路径」（路径从仓库根目录开始写，不用加/）

```bash
git sparse-checkout set 文件夹路径/文件夹名称
```

5. 拉取指定文件夹的所有内容

如果是仓库的其他分支名，比如master分支，需要将main换成master

```bash
git checkout main  
```



以下载[https://github.com/letere-gzj/live2d-widget-v3/tree/main/Resources](https://github.com/letere-gzj/live2d-widget-v3/tree/main/Resources)这个文件夹举例，依次输入以下指令：

```bash
git clone --filter=blob:none --no-checkout https://github.com/letere-gzj/live2d-widget-v3.git

cd live2d-widget-v3

git sparse-checkout init --cone

git sparse-checkout set Resources

git checkout main
```



