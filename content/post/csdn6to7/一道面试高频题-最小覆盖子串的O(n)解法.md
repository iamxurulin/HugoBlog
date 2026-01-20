---
title: "一道面试高频题-最小覆盖子串的O(n)解法"
date: 2025-12-08 22:09:20
categories:
- 算法
tags:
  - 二叉树
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/5db5cfd298f0471e87da4c30320e9eec.jpeg#pic_center)
### 求解思路

这道题我们可以把问题想象成"欠债还债"的过程:

一开始我们欠目标字符串 `tar` 中所有字符的债,然后用一个窗口在源字符串 `str` 上滑动,不断"还债"。

具体来说,我们用右指针 `r` 不断向右扩展窗口来收集字符还债,当债务全部还清时(也就是窗口已经包含了 `tar` 的所有字符),我们就尝试收缩左边界 `l` 来让这个窗口尽可能小,把那些"多给的"字符收回来。

在这个过程中,我们记录下遇到的最小窗口的位置和长度,最后返回这个最小窗口对应的子串就是答案。

### 举个栗子

假设 `str = "ADOBECODEBANC"`, `tar = "ABC"`:

1. 右指针扩展到 `ADOBEC` 时,debt 首次归零
2. 左指针收缩,去掉 `ADO`,得到 `BANC`
3. 继续右移,在 `CODEBA` 时再次覆盖
4. 收缩后得到 `BA`,但不满足(缺C)
5. 最终确定最小窗口是 `BANC`
### 代码实现

```java
public static String minWindow(String str, String tar) {
    if (str.length() < tar.length()) {
        return "";
    }
    char[] s = str.toCharArray();
    char[] t = tar.toCharArray();
    int[] cnts = new int[256];
    
    // 初始化欠债表:tar中的字符都标记为负数(欠债)
    for (char cha : t) {
        cnts[cha]--;
    }
    
    int len = Integer.MAX_VALUE;  // 最小覆盖子串的长度
    int start = 0;                // 最小覆盖子串的起始位置
    
    for (int l = 0, r = 0, debt = t.length; r < s.length; r++) {
        // 当前字符s[r]进入窗口,还债
        if (cnts[s[r]]++ < 0) {
            debt--;  // 只有真正需要的字符才能减少债务
        }
        
        if (debt == 0) {
            // 债务还清,找到了一个覆盖子串
            // 尝试收缩左边界,去掉多余字符
            while (cnts[s[l]] > 0) {
                cnts[s[l++]]--;
            }
            
            // 更新最小窗口
            if (r - l + 1 < len) {
                len = r - l + 1;
                start = l;
            }
        }
    }
    
    return len == Integer.MAX_VALUE ? "" : str.substring(start, start + len);
}
```

---
如果觉得有帮助，欢迎点赞、关注、转发~
