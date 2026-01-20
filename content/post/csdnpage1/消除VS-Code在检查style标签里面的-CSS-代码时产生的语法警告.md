---
title: "消除VS-Code在检查style标签里面的-CSS-代码时产生的语法警告"
date: 2026-01-18 15:21:15
categories:
- 项目
tags:
- Code
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/6c4b7ef4067c407aa6f51d16f728b362.png)
这个错误是编辑器的 CSS 校验器 不认识 Hugo 模板语法导致的**假报错**。

主要是在项目的 `terms.html` 文件中，有一段内联 CSS：

```css
CSSbackground: linear-gradient(135deg, 
    {{ ... }} 0%, 
    {{ ... }} 100%);
```

编辑器看到 `{{ ... }}` 这些内容时，以为这是普通的 CSS 代码，但实际上，这些 `{{ }}` 是 `Hugo` 的模板指令，这种假报错虽然不会影响站点运行，并且 `hugo server` 能正常启动、页面显示也没问题。

不过，想消除也不是没有办法，且看：

在项目的**根目录**下创建一个【.vscode】文件夹📂，然后创建一个【settings.json 】文件：

```bash
{
  "css.validate": false,
  "less.validate": false,
  "scss.validate": false
}
```

之后错误❌就消失了：
![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/3ae06805320e482b8bf9ef0b1ce73d92.png)

