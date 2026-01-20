---
title: "说说Computer Use的原理"
date: 2026-01-15 16:54:17
categories:
- AI
tags:
- 大模型
draft: false
---

Computer Use是让Claude能够操作计算机。

**实际工作原理：**

Claude通过截图观察屏幕的内容，基于视觉理解，Claude计算出需要点击或者输入的像素坐标，通过API发送鼠标移动、点击和键盘输入等指令，执行操作后再次截图，观察结果并决定下一步。

**Computer Use场景：**

- 在网页表单中填写信息并提交

- 执行需要多个软件协同的复杂工作流

- 操作如PS、PPT、Excel等桌面应用程序

