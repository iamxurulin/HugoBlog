---
title: "Leetcode316去除重复字母"
date: 2025-12-30 21:08:58
categories:
- 算法
tags:
  - 栈与队列
draft: false
---

![在这里插入图片描述](/images/40c74cc72f5940948200a6ca63fecd4e-d1eadd91.jpeg)
### 求解思路
构建大压小的单调栈。

建立词频表，统计字符串中每种字符出现的次数。

新字符入栈时，如果破坏了大压小的原则，看栈顶元素对应的字符在后面是否还有，如果有则栈顶元素出栈，新字符入栈；

如果栈里已有该字符，则直接跳过。
### 代码实现

```java
	public static int MAXN = 26;
	public static int[] cnts = new int[MAXN];
	public static boolean[] enter = new boolean[MAXN];
	public static char[] stack = new char[MAXN];
	public static int r;

	public static String removeDuplicateLetters(String str){
		r=0;
		Arrays.fill(cnts, 0);
		Arrays.fill(enter, false);

		char[] s = str.toCharArray();
		for(char cha:s){
			cnts[cha-'a']++;
		}

		for(char cur:s){
			if(!enter[cur-'a']){
				while(r>0&&stack[r-1]>cur&&cnts[stack[r-1]-'a']>0){
					enter[stack[r-1]-'a']=false;
					r--;
				}
				stack[r++]=cur;
				enter[cur-'a']=true;
			}
			cnts[cur-'a']--;
		}
		return String.valueOf(stack,0,r);
	}
```

