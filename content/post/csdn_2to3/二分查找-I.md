---
title: "二分查找-I"
date: 2026-01-09 22:09:01
categories:
- 算法
tags:
  - 数组
draft: false
---

![在这里插入图片描述](/images/ebf5bd3576b845e8b75d06178e40ff0c-dc8265de.jpeg)
### 求解代码

```java
public int search (int[] nums, int target) {
        // 左指针：起始下标
        int left = 0;
        // 右指针：结束下标，闭区间 [left, right]
        int right = nums.length - 1;

        while (left <= right) {

            int mid = left + ((right - left) >> 1);
            if (nums[mid] < target) {
                // 目标值在右半区，左指针右移
                left = mid + 1;
            } else if (nums[mid] == target) {
                // 找到目标值，返回对应下标
                return mid;
            } else {
                // 目标值在左半区，右指针左移
                right = mid - 1;
            }
        }
        // 遍历完无目标值，返回-1
        return -1;
    }
```

