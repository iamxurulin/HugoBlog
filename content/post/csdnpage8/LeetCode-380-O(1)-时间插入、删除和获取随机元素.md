---
title: "LeetCode 380: O(1) 时间插入、删除和获取随机元素"
date: 2025-10-22 21:10:40
categories:
- 算法
tags:
- leetcode
draft: false
---


![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/ed1235d75ede4586a59dcf1627982cbf.png#pic_center)
这道题的难点在于如何同时满足三个 O(1) 操作,尤其是**随机获取元素**。

### 代码逻辑

#### 1. 插入操作 (insert)

```java
public boolean insert(int val) {
    if (map.containsKey(val)) {
        return false;  // 元素已存在
    }
    map.put(val, arr.size());  // 记录新元素的索引
    arr.add(val);               // 添加到数组末尾
    return true;
}
```
#### 2. 删除操作 (remove)

直接从数组中间删除元素的时间复杂度是 O(n),因此本文采用**交换删除法**:

```java
public boolean remove(int val) {
    if (!map.containsKey(val)) {
        return false;  // 元素不存在
    }
    
    // 获取要删除元素的索引
    int valIndex = map.get(val);
    
    // 获取数组最后一个元素
    int endValue = arr.get(arr.size() - 1);
    
    // 用最后一个元素覆盖要删除的元素
    map.put(endValue, valIndex);
    arr.set(valIndex, endValue);
    
    // 删除 map 中的记录和数组末尾元素
    map.remove(val);
    arr.remove(arr.size() - 1);
    
    return true;
}
```

将要删除的元素与数组最后一个元素交换,然后删除末尾元素,这样删除操作就是 O(1) 了!
#### 3. 随机获取 (getRandom)

```java
public int getRandom() {
    return arr.get((int) (Math.random() * arr.size()));
}
```

使用了 ArrayList,可以通过索引 O(1) 访问任意元素,配合随机数生成器即可实现等概率随机返回。

**完整代码**

```java
class RandomizedSet{
        public HashMap<Integer,Integer> map;
        public ArrayList<Integer> arr;
        public RandomizedSet(){
            map = new HashMap<>();
            arr = new ArrayList<>();
        }

        public boolean insert(int val) {
            if (map.containsKey(val)) {
                return false;  // 元素已存在
            }
            map.put(val, arr.size());  // 记录新元素的索引
            arr.add(val);               // 添加到数组末尾
            return true;
        }

        public boolean remove(int val) {
            if (!map.containsKey(val)) {
                return false;  // 元素不存在
            }

            // 获取要删除元素的索引
            int valIndex = map.get(val);

            // 获取数组最后一个元素
            int endValue = arr.get(arr.size() - 1);

            // 用最后一个元素覆盖要删除的元素
            map.put(endValue, valIndex);
            arr.set(valIndex, endValue);

            // 删除 map 中的记录和数组末尾元素
            map.remove(val);
            arr.remove(arr.size() - 1);

            return true;
        }

        public int getRandom(){
            return arr.get((int) (Math.random()*arr.size()));
        }
    }
```

