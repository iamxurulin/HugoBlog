---
title: "PO、VO、BO、DTO、DAO、POJO有什么区别"
date: 2026-01-08 17:58:10
categories:
- 八股
tags:
  - Java
draft: false
---

PO（Persistent Object）持久化对象，主要用于和数据库交互，是数据库数据在内存中的镜像。

VO（View Object）视图对象，和前端展示强相关，按需组装前端需要的字段。

BO（Business Object）业务对象，封装业务逻辑，包含业务处理方法，是业务层专用，业务层只操作BO，不直接碰PO/DTO。

DTO（Data Transfer Object）数据传输对象，屏蔽底层 PO 结构，可细分 ReqDTO（请求）和 ResDTO（响应），用于跨层或者跨服务传输数据。

DAO（Data Access Object）数据访问对象，负责和数据库打交道，隔离业务逻辑和数据操作，依赖PO，通过操作PO完成与数据库的交互。

POJO（Plain Ordinary Java Object）简单Java对象，最基础的Java类。

**PO/VO/BO/DTO 本质上都是 POJO。**

常见的**调用链路**：

前端请求 → Controller接收【ReqDTO】→ Service将ReqDTO转为【BO】→ BO调用【DAO】→ DAO操作【PO】与数据库交互 → Service将BO/PO转为【ResDTO/VO】→ Controller返回给前端
