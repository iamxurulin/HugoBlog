---
title: "LeetCode-381-O(1)-时间插入、删除和获取随机元素-允许重复"
date: 2025-10-23 20:48:13
categories:
- 算法
tags:
  - HashMap
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/384d8c6e646e4663a65605949ce9e8e4.png#pic_center)

与[Leetcode380](https://blog.csdn.net/qq_44678890/article/details/153745801?spm=1001.2014.3001.5501)不同的是，这道题**允许元素重复**。
### 代码逻辑
#### 1. 插入操作

```java
public boolean insert(int val) {
    arr.add(val);  // 直接添加到数组末尾
    HashSet<Integer> set = map.getOrDefault(val, new HashSet<Integer>());
    set.add(arr.size() - 1);  // 记录该元素在数组中的索引
    map.put(val, set);
    return set.size() == 1;  // 如果是第一次插入,返回 true
}
```
将元素添加到数组末尾,同时在 HashMap 中记录其索引位置。

#### 2. 删除操作

```java
public boolean remove(int val) {
    if (!map.containsKey(val)) {
        return false;
    }
    
    // 获取要删除元素的任意一个索引
    HashSet<Integer> valSet = map.get(val);
    int valAnyIndex = valSet.iterator().next();
    
    // 获取数组末尾元素
    int endValue = arr.get(arr.size() - 1);
    
    if (val == endValue) {
        // 特殊情况:要删除的就是末尾元素
        valSet.remove(arr.size() - 1);
    } else {
        // 将末尾元素移动到要删除的位置
        HashSet<Integer> endValueSet = map.get(endValue);
        endValueSet.add(valAnyIndex);  // 末尾元素有了新位置
        arr.set(valAnyIndex, endValue);  // 更新数组
        endValueSet.remove(arr.size() - 1);  // 移除末尾位置
        valSet.remove(valAnyIndex);  // 移除被删除元素的位置
    }
    
    arr.remove(arr.size() - 1);  // 删除数组末尾
    
    if (valSet.isEmpty()) {
        map.remove(val);  // 如果该值已经没有了,从 map 中删除
    }
    
    return true;
}
```

ArrayList 删除中间元素是 O(n) 操作,但删除末尾元素是 O(1)，因此我们把要删除的元素和末尾元素**交换**,然后删除末尾。
#### 3. 随机获取

```java
public int getRandom() {
    return arr.get((int) (Math.random() * arr.size()));
}
```

**完整代码**

```java
class RandomizedCollection{
		public HashMap<Integer,HashSet<Integer>> map;
		public ArrayList<Integer> arr;
		public RandomizedCollection(){
			map = new HashMap<>();
			arr = new ArrayList<>();
		}

		public boolean insert(int val) {
			arr.add(val);  // 直接添加到数组末尾
			HashSet<Integer> set = map.getOrDefault(val, new HashSet<Integer>());
			set.add(arr.size() - 1);  // 记录该元素在数组中的索引
			map.put(val, set);
			return set.size() == 1;  // 如果是第一次插入,返回 true
		}

		public boolean remove(int val) {
			if (!map.containsKey(val)) {
				return false;
			}

			// 获取要删除元素的任意一个索引
			HashSet<Integer> valSet = map.get(val);
			int valAnyIndex = valSet.iterator().next();

			// 获取数组末尾元素
			int endValue = arr.get(arr.size() - 1);

			if (val == endValue) {
				// 特殊情况:要删除的就是末尾元素
				valSet.remove(arr.size() - 1);
			} else {
				// 将末尾元素移动到要删除的位置
				HashSet<Integer> endValueSet = map.get(endValue);
				endValueSet.add(valAnyIndex);  // 末尾元素有了新位置
				arr.set(valAnyIndex, endValue);  // 更新数组
				endValueSet.remove(arr.size() - 1);  // 移除末尾位置
				valSet.remove(valAnyIndex);  // 移除被删除元素的位置
			}

			arr.remove(arr.size() - 1);  // 删除数组末尾

			if (valSet.isEmpty()) {
				map.remove(val);  // 如果该值已经没有了,从 map 中删除
			}

			return true;
		}

		public int getRandom(){
			return arr.get((int) (Math.random()*arr.size()));
		}
	}
```

