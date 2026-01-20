---
title: "TS7016: Could not find a declaration file for module ‘vue-router‘.解决办法"
date: 2025-12-25 15:45:44
tags:
- 前端
draft: false
---

前端初始化的时候出现这样一个错误：

```typescript
ERROR in src/router/index.ts:1:64                                                                                                                                    
TS7016: Could not find a declaration file for module 'vue-router'. './node_modules/vue-router/index.js' implicitly has an 'any' type.
  Try npm i --save-dev @types/vue-router if it exists or add a new declaration (.d.ts) file containing declare module 'vue-router';
  > 1 | import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router";
      |                                                                ^^^^^^^^^^^^
    2 | import HomeView from "../views/HomeView.vue";
```
我尝试了以下方法：

```typescript
# 使用 PowerShell
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json

# 清理 npm 缓存
npm cache clean --force

# 重新安装
npm install
```
重新运行package.jason文件的serve仍然不行；

再次尝试新建 src/shims-vue-router.d.ts文件：

```typescript
declare module 'vue-router' {
  import type { App, Component } from 'vue'

  export interface RouteRecordRaw {
    path: string
    name?: string | symbol
    component?: Component
    components?: Record<string, Component>
    redirect?: string
    alias?: string | string[]
    children?: RouteRecordRaw[]
    meta?: Record<string, any>
    beforeEnter?: NavigationGuard | NavigationGuard[]
    props?: boolean | Record<string, any> | ((to: any) => Record<string, any>)
  }

  export interface Router {
    currentRoute: any
    push(to: any): Promise<any>
    replace(to: any): Promise<any>
    go(delta: number): void
    back(): void
    forward(): void
    beforeEach(guard: NavigationGuard): () => void
    afterEach(guard: NavigationHookAfter): () => void
    install(app: App): void  // 添加这行,让 Router 可以作为 Vue 插件使用
  }

  export interface NavigationGuard {
    (to: any, from: any, next: any): any
  }

  export interface NavigationHookAfter {
    (to: any, from: any): any
  }

  export function createRouter(options: any): Router
  export function createWebHistory(base?: string): any
  export function createWebHashHistory(base?: string): any
  export function createMemoryHistory(base?: string): any
  export function useRouter(): Router
  export function useRoute(): any
}
```
这下可以了：

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/7453f1b5fab04c05866572bf0708cbca.png)

