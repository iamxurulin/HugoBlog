---
title: "全排列II-一个HashSet搞定去重难题"
date: 2025-11-14 21:11:12
categories:
- 算法
tags:
  - 搜索
draft: false
---

![在这里插入图片描述](/images/3b9a4c50ff8f4c12be90410f74c73d10-c2902b52.png)
### 求解思路

这题如果直接套用普通全排列的模板，会得到 6 个结果，其中有重复！因此，难点在于去重。

这里采用位置固定法结合回溯来生成排列：

从左到右依次确定每个位置，对于位置 i，尝试把 [i, n) 范围内的每个数字交换到位置 i，然后递归处理位置 i+1。

**去重的关键在于**：用一个 HashSet 记录当前位置已经尝试过的数字，如果某个值已经被尝试过了就直接跳过，这样就能从源头避免重复排列的产生
### 完整代码

```java
public static List<List<Integer>> permuteUnique(int[] nums){
        List<List<Integer>> ans = new ArrayList<>();
        f(nums,0,ans);
        return ans;
    }

    public static void f(int[] nums,int i,List<List<Integer>> ans){
        if(i==nums.length){
            List<Integer> cur = new ArrayList<>();
            for (int num:nums){
                cur.add(num);
            }
            ans.add(cur);
        }else{
            HashSet<Integer> set = new HashSet<>();
            for (int j = i; j < nums.length; j++) {
                // 关键判断：这个值在位置i没试过，才去尝试
                if (!set.contains(nums[j])) {
                    set.add(nums[j]);       // 标记已尝试
                    swap(nums, i, j);       // 做选择
                    f(nums, i + 1, ans);    // 递归
                    swap(nums, i, j);       // 撤销选择
                }
            }
        }
    }

    public static void swap(int[] nums,int i,int j){
        int tmp = nums[i];
        nums[i]=nums[j];
        nums[j]=tmp;
    }

```

---
如果觉得有帮助，欢迎点赞、关注、转发~
