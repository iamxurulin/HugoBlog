---
title: "Github仓库上传图片并获取URL"
date: 2025-10-26 11:16:02
categories:
- 项目
tags:
- Git
draft: false
---

网上有很多免费的在线图床能够做到快速上传图片并获取URL。

但是作为一个纯粹的技术人，我还是想通过专业一点的手法实现这样一个功能。

利用GitHub的公共仓库存储图片，再通过仓库的文件原始链接（Raw URL）获取图片地址，能够免费无限存储、URL永久有效。

下面介绍采用Edge浏览器在GitHub网页端进行操作。

### 操作步骤

1.在 [GitHub官网](https://github.com/) 免费注册一个账号，并登录。


2.创建一个公共仓库，因为GitHub的私有仓库文件URL需要权限验证，无法直接公开访问，所以这里必须创建**公共仓库**。

 - 「Repository name」：取一个名字（例如`picture-storage`）。  
 - 「Description」：比如“图片存储库”。  
 - 勾选「Public」（必须公开，否则图片URL无法直接访问）。  
 - 勾选「Add a README file」（方便管理）。
  ![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/d0bf6dbbb2534148bf0ede2462b619aa.png)
3.进入创建的仓库（例如 `https://github.com/你的用户名/picture-storage`），上传图片：
![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/7054051b810b436593c63fdf44f1e23e.png)
 - 点击「+」图标，选择「Upload files」 
 - 点击「choose your files」选择本地的图片进行上传
 - 选择好图片后在「Commit changes」区域填写备注（例如“上传头像图片”），然后点击「Commit changes」确认上传。

4.上传后，图片会保存在仓库中，由于普通预览链接无法直接显示图片，需要获取其“原始文件链接”（Raw URL）。

 - 在仓库中找到刚上传的图片，点击图片名称进入预览页面（例如 `https://github.com/你的用户名/picture-storage/blob/main/xxx.png`）；  
 - 在图片预览页面，右键点击图片，选择「在新标签页中打开图像」；
 - 在新的标签页地址栏的URL就是Raw链接（例如
   `https://raw.githubusercontent.com/你的用户名/picture-storage/main/xxx.png`），直接复制即可。

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/ec0bd540ed334d9fbecf4da0186e35bf.png)

通过以上步骤，即可快速通过GitHub上传图片并获取可用的URL，适用于Markdown文档、个人博客、社交平台等场景。
