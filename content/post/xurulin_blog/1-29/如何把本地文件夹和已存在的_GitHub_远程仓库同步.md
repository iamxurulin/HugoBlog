---
title: "如何把本地文件夹和已存在的 GitHub 远程仓库同步"
date: 2026-01-28 17:13:44
categories:
  - 项目
tags:
  - Git
draft: false
---

在[GITHUB仓库上传图片并获取URL](https://blog.csdn.net/qq_44678890/article/details/153917062?ops_request_misc=%257B%2522request%255Fid%2522%253A%252232fa1bfbf414848447621c5ad8e40633%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=32fa1bfbf414848447621c5ad8e40633&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-1-153917062-null-null.nonecase&utm_term=%E5%9B%BE%E5%BA%8A&spm=1018.2226.3001.4450) 这篇博客中介绍了如何搭建自己的图床，现在收集了一些图片，想更新一下里面的图片。

那如何把本地文件夹和已存在的 GitHub 远程仓库同步呢？

现在的问题是：

- GitHub 上已经有一个仓库，里面有一些**图片+README.md**

- 本地已经建好了一个文件夹，里面放了很多其他图片

我希望**先把远程仓库的文件拉到本地**，**再把本地新增的图片推送上去**，最终实现双向同步。

下面分享一个**安全且不容易出错**的流程，亲测可用。

### 1.进入现在的本地文件夹

```bash
cd /path/to/本地图片文件夹
```

### 2.初始化并关联远程

```bash
git init
git remote add origin git@github.com:/你的用户名/你的仓库名.git
```

推荐使用ssh，原因和操作可参考[配置ssh解决https不稳定的问题](https://blog.csdn.net/qq_44678890/article/details/156897818?ops_request_misc=%257B%2522request%255Fid%2522%253A%25221f28d3ab9dc693a75e1f21cb95ce575f%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=1f28d3ab9dc693a75e1f21cb95ce575f&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_ecpm_v1~rank_v31_ecpm-1-156897818-null-null.nonecase&utm_term=ssh&spm=1018.2226.3001.4450) 。

### 3.拉取远程内容

```bash
# 从名叫 “origin” 的远程仓库（通常就是你的GitHub仓库）拉取（fetch）最新的数据
git fetch origin

#把你的工作目录切换（checkout）到名叫 “main” 的分支
git checkout main
```

这一步会把远程的文件下载到本地。

这里解释一下`git fetch`跟 `git pull` 的区别：

- git fetch：只下载，不合并（安全、无副作用）

- git pull：相当于 `git fetch` +` git merge`（下载完立刻合并到当前分支，可能会改你本地文件）

### 4.添加本地文件并推送

```bash
git add .
git commit -m "合并本地图片到远程仓库"
git push origin main
```

以上方法亲测可行，当然，如果害怕出错，最稳的做法是**先 clone 远程仓库到一个新目录➡️复制本地文件进去 ➡️commit & push**。

这样既能保留远程的文件，又能安全地把本地新增内容上传上去，避免各种奇怪的冲突。
