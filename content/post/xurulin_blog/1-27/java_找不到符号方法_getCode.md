---
title: "java: 找不到符号方法 getCode()"
date: 2026-01-27 12:56:48
categories:
  - 项目
tags:
  - Code
draft: false
---

运行Spring Boot工程代码出现以下报错：

```bash
位置: 类型为com.xx.xx.exception.ErrorCode的变量 errorCode
```
### 解决方法
![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/9b9fa382f8674a299650e667d45c7df9.png)
看截图中间那个路径框：

```bash
...lombok\unknown\lombok-unknown.jar
```

这里的 `unknown` 说明 IDEA 根本没找到 `Lombok` 的 `jar` 包。

接下来，

把选中的 “处理器路径” 改为上面那个选项 —— “从项目类路径获取处理器 ”。

因为项目是 `Maven` 管理的，`Maven` 已经下载好了 `Lombok`（在 `pom.xml` 里），这样的话 IDEA就可以直接用 `Maven` 下载好的那个包了。

保存并重试，问题解决。


