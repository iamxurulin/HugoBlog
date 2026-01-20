---
title: "Spring Bean一共有几种作用域？"
date: 2026-01-05 14:53:26
categories:
- 八股
tags:
- Java
draft: false
---

六种。

|singleton|默认是单例，一个 Spring IOC容器的内部只有一个Bean实例  |
|--|--|
|  prototype|原型，每次获取都会新建实例|
| request |每个请求都会新建一个属于自己的Bean实例  |
| session |一个http session中有一个Bean的实例  |
|  application|整个ServletContext生命周期里，只有一个Bean实例  |
| websocket |一个WebSocket生命周期内只有一个Bean实例  |

request、session、application、websocket这四种作用域都是只存在于Spring Web应用中的。
