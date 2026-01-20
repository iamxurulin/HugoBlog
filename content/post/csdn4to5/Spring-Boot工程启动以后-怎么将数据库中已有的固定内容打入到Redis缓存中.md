---
title: "Spring-Boot工程启动以后-怎么将数据库中已有的固定内容打入到Redis缓存中"
date: 2025-12-31 15:49:46
categories:
- 八股
tags:
  - Java
draft: false
---

要想实现在Spring Boot工程启动之后，直接将数据库中已有的固定内容打入到Redis缓存中，首先需要确保实体类已经实现了Serializable接口，并且已经正确配置了RedisTemplate的序列化方式 。

可以考虑使用CommanLineRunner或者ApplicationRunner**接口**，在应用启动完成后执行初始化逻辑；

也可以通过@PostConstruct注解，在Bean创建之后立即执行数据库加载。

在懒加载场景，可以使用@Cacheable注解，在首次调用方法时触发缓存写入，完成预加载。



