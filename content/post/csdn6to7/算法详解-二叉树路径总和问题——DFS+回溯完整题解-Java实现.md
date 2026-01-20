---
title: "【算法详解】二叉树路径总和问题——DFS+回溯完整题解（Java实现）"
date: 2025-11-06 21:00:24
categories:
- 算法
- 八股
tags:
- 算法
- Java
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/2892799f567346c7b776d92c957bf50f.png#pic_center)
### 求解思路
从根节点出发，沿着路径向下遍历，记录当前路径经过的所有节点。当到达叶子节点时，判断路径和是否等于目标值。然后回溯到父节点，继续探索其他路径，直到遍历完所有可能的路径。
### 递归流程分析

#### 1. 叶子节点的处理

```java
if (cur.left == null && cur.right == null) {
    // 到达叶子节点
    if (cur.val + sum == aim) {
        path.add(cur.val);           // 加入当前节点
        copy(path, ans);             // 拷贝路径到结果集
        path.remove(path.size() - 1); // 回溯，移除当前节点
    }
}
```
#### 2. 非叶子节点的处理

```java
else {
    path.add(cur.val);              // 做选择: 加入当前节点
    
    if (cur.left != null) {
        f(cur.left, aim, sum + cur.val, path, ans);  // 递归左子树
    }
    if (cur.right != null) {
        f(cur.right, aim, sum + cur.val, path, ans); // 递归右子树
    }
    
    path.remove(path.size() - 1);   // 撤销选择: 回溯
}
```
---
### 完整代码实现

```java
public static List<List<Integer>> pathSum(TreeNode root, int aim) {
    List<List<Integer>> ans = new ArrayList<>();
    if (root != null) {
       List<Integer> path = new ArrayList<>();
       f(root, aim, 0, path, ans);
    }
    return ans;
}

public static void f(TreeNode cur, int aim, int sum, 
                     List<Integer> path, List<List<Integer>> ans) {
    if (cur.left == null && cur.right == null) {
       // 叶节点
       if (cur.val + sum == aim) {
          path.add(cur.val);
          copy(path, ans);
          path.remove(path.size() - 1);
       }
    } else {
       // 非叶节点
       path.add(cur.val);
       if (cur.left != null) {
          f(cur.left, aim, sum + cur.val, path, ans);
       }
       if (cur.right != null) {
          f(cur.right, aim, sum + cur.val, path, ans);
       }
       path.remove(path.size() - 1);
    }
}

public static void copy(List<Integer> path, List<List<Integer>> ans) {
    List<Integer> copy = new ArrayList<>();
    for (Integer num : path) {
       copy.add(num);
    }
    ans.add(copy);
}
```

---
如果觉得有帮助，欢迎点赞、关注、转发~
