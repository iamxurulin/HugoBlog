---
title: "O(1)时间复杂度实现有setAll功能的哈希表"
date: 2025-10-20 21:55:45
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/c86d966bd006465b8e507847ce7091b4.png#pic_center)
### 代码逻辑

这道题的核心在于:

不直接修改所有数据,而是记录一个全局更新时间戳。

通过比较每个元素的更新时间和全局更新时间,动态判断应该返回哪个值。

#### 1. put(k, v) 

```java
public static void put(int k, int v) {
    if (map.containsKey(k)) {
        // 键已存在,更新值和时间戳
        int[] value = map.get(k);
        value[0] = v;
        value[1] = cnt++;
    } else {
        // 新键,创建新的 [value, timestamp] 数组
        map.put(k, new int[]{v, cnt++});
    }
}
```
每次存值时，不仅存具体的value，还会记录当前的cnt（时间戳），然后cnt自增。
### 2. setAll(v)

```java
public static void setAll(int v) {
    setAllValue = v;      // 记录全局值
    setAllTime = cnt++;   // 记录全局更新时间
}
```

记录了 “全局值”setAllValue和 “全局更新时间”setAllTime（同样用cnt作为时间戳，然后cnt自增）。

### 3. get(k)

```java
public static int get(int k) {
    if (!map.containsKey(k)) {
        return -1;
    }
    
    int[] value = map.get(k);
    // 比较时间戳
    if (value[1] > setAllTime) {
        // 单个元素的更新时间晚于全局更新,返回元素自己的值
        return value[0];
    } else {
        // 单个元素的更新时间早于或等于全局更新,返回全局值
        return setAllValue;
    }
}
```

**完整代码**

```java
public class SetAllHashMap {
	// 存储实际的键值对,值是一个数组 [value, timestamp]
	public static HashMap<Integer,int[]> map = new HashMap<>();
	// 全局设置的值
	public static int setAllValue;
	// 全局设置的时间戳
	public static int setAllTime;
	// 全局计数器,用于生成递增的时间戳
	public static int cnt;

	public static void put(int k, int v) {
		if (map.containsKey(k)) {
			// 键已存在,更新值和时间戳
			int[] value = map.get(k);
			value[0] = v;
			value[1] = cnt++;
		} else {
			// 新键,创建新的 [value, timestamp] 数组
			map.put(k, new int[]{v, cnt++});
		}
	}

	public static void setAll(int v) {
		setAllValue = v;      // 记录全局值
		setAllTime = cnt++;   // 记录全局更新时间
	}

	public static int get(int k) {
		if (!map.containsKey(k)) {
			return -1;
		}

		int[] value = map.get(k);
		// 比较时间戳
		if (value[1] > setAllTime) {
			// 单个元素的更新时间晚于全局更新,返回元素自己的值
			return value[0];
		} else {
			// 单个元素的更新时间早于或等于全局更新,返回全局值
			return setAllValue;
		}
	}

	public static int n,op,a,b;

	public static void main(String[] args)throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		StreamTokenizer in = new StreamTokenizer(br);
		PrintWriter out = new PrintWriter(new OutputStreamWriter(System.out));
		while(in.nextToken()!=StreamTokenizer.TT_EOF){
			map.clear();
			setAllValue = 0;
			setAllTime  = -1;
			cnt = 0;
			n = (int) in.nval;
			for(int i=0;i<n;i++){
				in.nextToken();
				op = (int) in.nval;
				if(op==1){
					in.nextToken();
					a=(int)in.nval;
					in.nextToken();
					b = (int) in.nval;
					put(a,b);
				}else if(op==2){
					in.nextToken();
					a=(int)in.nval;
					out.println(get(a));
				}else{
					in.nextToken();
					a=(int)in.nval;
					setAll(a);
				}
			}
		}
		out.flush();
		out.close();
		br.close();
	}

}
```
