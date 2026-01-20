---
title: "说说Java中的反射机制"
date: 2026-01-18 17:36:55
categories:
- 八股
tags:
  - Java
draft: false
---

反射机制是让程序在**运行的时候**能够动态地**获取**类的**方法、字段、构造函数**这些结构信息，还能对其直接进行操作，这样，程序在编译时不需要知道具体的类型，等到**运行时再决定**要调用哪个类和方法。

## 反射机制主要有3大核心流程：

获取Class对象➡️获取成员信息➡️操作目标对象。


## 获取Class对象的方式：

- 1.全限定类名获取

```java
Class<?> cla = Class.forName("xxx.xxx.MyClass");
```

- 2.字面量获取

```java
Class<?> cla = MyClass.class;
```

- 3.对象实例获取

```java
Class<?> cla = obj.getClass();
```
### 获取成员信息

主要是从Class对象中获取字段Field、方法Method以及构造函数Constructor

### 操作目标对象

主要是创建实例、读写字段和调用方法。


