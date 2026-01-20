---
title: "TS2307: Cannot find module ‘./App.vue‘ or its corresponding type declarations解决办法"
date: 2025-11-16 11:03:15
tags:
- 前端
draft: false
---

这个错误是 TypeScript（TS）无法识别 .vue 文件模块导致的，原因是 缺少 Vue 相关的类型声明配置。

**解决办法：**

1.先执行以下命令，确保项目中已安装 Vue 核心依赖和类型声明文件：

```bash
# Vue 3 项目
npm install vue@3
npm install -D @vue/tsconfig @vue/runtime-core @types/node
```

2.添加 Vue 类型声明文件

在项目 src 目录下新建文件 shims-vue.d.ts（文件名固定，TS 会自动识别）：

```typescript
// src/shims-vue.d.ts
declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  // 泛型参数：Props类型、Emits类型、Slots类型（默认任意）
  const component: DefineComponent<{}, {}, any>
  export default component
}
```
如果觉得有帮助，欢迎点赞、关注、转发~
