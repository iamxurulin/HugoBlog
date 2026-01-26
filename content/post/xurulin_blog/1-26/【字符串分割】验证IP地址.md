---
title: "【字符串分割】验证IP地址"
date: 2026-01-25 22:00:54
categories:
  - 算法
tags:
  - 字符串
draft: false
---

![在这里插入图片描述](/images/9b52ccbab7ad4a96be480548bacd53a4-6480cf44.png)
![在这里插入图片描述](/images/1399c53018cd43a1aa6f1689e7af2c77-2db4af27.png)
### 求解代码
```java
public String solve(String IP) {
        // 校验是否为IPv4
        if (IP.indexOf(".") != -1) {
            // 按.分割，.是正则通配符，需转义为\\.
            String[] strs = IP.split("\\.");
            // IPv4核心规则：必须被.分割为4段
            if (strs.length != 4) {
                return "Neither";
            }
            // 校验IPv4
            for (int i = 0; i < strs.length; i++) {
                // 提前校验段非空，避免空串导致charAt/parseInt运行时异常
                if (strs[i].isEmpty()) {
                    return "Neither";
                }
                // 当前段仅能包含数字0-9
                for (char c : strs[i].toCharArray()) {
                    if (!(c >= '0' && c <= '9')) {
                        return "Neither";
                    }
                }
                // 数值≤255 且 无前导零（唯一例外：段本身是0，即长度1的0）
                if (Integer.parseInt(strs[i]) > 255 || (strs[i].charAt(0) == '0' && strs[i].length() > 1)) {
                    return "Neither";
                }
            }
            // 所有IPv4规则校验通过
            return "IPv4";
        }
        // 校验是否为IPv6
        else if (IP.indexOf(":") != -1) {
            // IPv6首尾不能为:
            if (IP.charAt(0) == ':' || IP.charAt(IP.length() - 1) == ':') {
                return "Neither";
            }
            // 按:分割IPv6字符串
            String[] strs = IP.split(":");
            // IPv6必须被:分割为8段
            if (strs.length != 8) {
                return "Neither";
            }
            // 校验IPv6
            for (int i = 0; i < strs.length; i++) {
                // 当前段仅能包含十六进制字符
                for (char c : strs[i].toCharArray()) {
                    if (!(c >= '0' && c <= '9') && !(c >= 'a' && c <= 'f') && !(c >= 'A' && c <= 'F')) {
                        return "Neither";
                    }
                }
                // 段不能为空 且 长度≤4
                if (strs[i].equals("") || strs[i].length() > 4) {
                    return "Neither";
                }
            }
            // 所有IPv6规则校验通过
            return "IPv6";
        }
        // 既不包含.也不包含:，直接判定为非法IP
        else {
            return "Neither";
        }
    }
```
### 小贴士
题目意思不是太难理解，就是可能有点繁琐。
理清思路应该问题不大。
