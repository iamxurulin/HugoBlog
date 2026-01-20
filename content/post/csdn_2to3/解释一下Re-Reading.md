---
title: "解释一下Re-Reading"
date: 2026-01-12 15:32:15
categories:
- AI
tags:
- 大模型
draft: false
---

Re-Reading（重读），是一种通过让大语言模型**重新阅读问题**来提高其推理能力的技术。

有文献研究证明：

对于复杂的问题，重复阅读和审视问题有助于模型更好地理解题意和约束，从而能够生成更准确、更深入的回答。

在Spring AI中，可以通过自定义Advisor来实现Re-Reading功能：

1.创建自定义Advisor类，同时实现用于同步请求的CallAroundAdvisor接口和用于流式请求的StreamAroundAdvisor接口，实现后可以兼容所有大模型调用场景。

2.在Advisor的前置处理逻辑中，对用户的原始输入文本进行**重读式Prompt增强改写**。

3.将改写后的提示词传递给**大语言模型**进行处理。

