---
title: "后端 Long 类型 ID 传给前端精度丢失（变00）的解决方案"
date: 2026-01-28 13:23:17
categories:
  - 项目
tags:
  - Code
draft: false
---

在前后端分离的开发中，数据库里存的主键 ID 明明是：`1750433246798835714`，但是前端接收到数据后，ID 却变成了：`1750433246798835700`，后几位莫名其妙变成了 0！

导致的结果就是：

前端拿这个错误的 ID 去查询详情或执行删除操作时，后端直接报错“数据不存在”，因为 ID 对不上。

### 原因分析

这个问题的根源在于 Java 和 JavaScript 对数字处理机制的不同。

Java 中的 Long 类型是 64 位有符号整数，它的取值范围非常大；

而常用的雪花算法 (Snowflake) 生成的 ID 通常就是 19 位的，完全在 Java 的 Long 范围内。

JavaScript 中并没有专门的整数类型，所有的数字本质上都是 IEEE 754 标准的双精度浮点数（Double）。

JS 能安全表示的最大整数（Safe Integer）是253-1,这就导致后端的 19 位 ID传给前端时，因为超过了 JS 的安全整数范围，JS 就会发生精度丢失，自动进行“四舍五入”或者直接丢弃低位，导致后几位变成 0。

### 解决方案

要解决这个问题，最简单有效的方法是：

后端在返回数据给前端时，把 Long 类型的数据统统转换成 String类型。

因为字符串在 JS 里是绝对安全的，不会发生精度丢失。

不需要手动去改每一个 DTO 或 VO 类，只需要在 Spring Boot 中加一个全局配置类，利用 Jackson 的序列化机制自动完成转换。

直接在 `config` 包下新建一个类`JsonConfig.java`：

```java
/**
 * Spring MVC全局Json配置
 * 用于解决 Long 类型精度丢失问题
 */
@JsonComponent
public class JsonConfig {

    /**
     * 全局配置：将 Long 类型序列化为 String
     */
    @Bean
    public ObjectMapper jacksonObjectMapper(Jackson2ObjectMapperBuilder builder) {
        // 创建 ObjectMapper
        ObjectMapper objectMapper = builder.createXmlMapper(false).build();
        
        // 创建自定义序列化模块
        SimpleModule module = new SimpleModule();
        
        // 将 Long 类（包装类）和 long（基本类型）都序列化为字符串
        // ToStringSerializer.instance 会调用对象的 toString() 方法
        module.addSerializer(Long.class, ToStringSerializer.instance);
        module.addSerializer(Long.TYPE, ToStringSerializer.instance);

        // 注册模块
        objectMapper.registerModule(module);
        
        return objectMapper;
    }
}
```

使用这种全局配置 方案，可以一劳永逸地解决项目中所有 Long 类型精度丢失的问题。
