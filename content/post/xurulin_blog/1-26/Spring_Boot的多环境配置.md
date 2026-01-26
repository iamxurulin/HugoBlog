---
title: "Spring Boot的多环境配置"
date: 2026-01-26 15:27:48
categories:
  - 八股
tags:
  - Java
draft: false
---

在开发Spring Boot项目中，如果我们想把自己的项目开源到Github仓库，`application.yml`中的某些配置比如`MySQL`、`Redis`的账户密码，还有的就是现在引入AI之后的一些密钥，可能都不太愿意推送到仓库去。

这个时候，可以通过配置多环境来解决，给本地一个专有的配置文件，然后将其添加到`.gitignore`文件中，这样就有效解决了这个问题。

下面介绍一下 Spring Boot的多环境配置方法：

Spring Boot 支持的多环境配置文件，命名规则为 `application-{profile}.yml`（`profile` 是环境标识，如`local/dev/test/prod`）。

### 操作步骤
1. `application.yml`（公共配置）

```yaml
spring:
  application:
    name: xxx
  profiles:
    active: local  # 激活local环境

# springdoc-openapi（所有环境都用这个扫描包，通用）
springdoc:
  group-configs:
    - group: 'default'
      packages-to-scan: com.xx.xx.controller

# knife4j（所有环境都开启，中文界面，通用）
knife4j:
  enable: true
  setting:
    language: zh_cn
```

2. `application-local.yml`（本地开发专属配置）

```yaml
# 本地专属：端口、上下文路径
server:
  port: xxxx
  servlet:
    context-path: /api

# 本地专属的其他配置（比如数据库、日志、Redis等）
# spring:
#   datasource:
#     url: jdbc:mysql://localhost:3306/xx?useSSL=false&serverTimezone=UTC
#     username: xx
#     password: xx
#     driver-class-name: com.mysql.cj.jdbc.Driver
# logging:
#   level:
#     com.xx.xx: debug  # 本地开发开启debug日志
# redis:
#   host: localhost
#   port: xxxx
```

通过在 `application.yml` 中配置 `spring.profiles.active` 激活指定环境，最后的加载顺序就是：

 - 先加载公共配置 `application.yml`；

- 再加载激活的环境配置 `application-local.yml`；


这样的话，环境配置中的**同名配置项**会覆盖公共配置，**不同配置项**自动合并，实现 “公共 + 专属” 并存。
