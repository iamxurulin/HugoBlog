---
title: "树形DP解决打家劫舍问题"
date: 2025-11-10 20:15:19
categories:
- 算法
tags:
  - 二叉树
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/5e7f25c11f474fcf8b173c1fc41b772c.png#pic_center)

今天来看一个经典的树形动态规划问题——**打家劫舍III**。
### 核心思路

定义两个状态:
- **yes**: 偷当前节点时,以该节点为根的子树能获得的最大收益
- **no**: 不偷当前节点时,以该节点为根的子树能获得的最大收益

通过递归遍历树,在回溯过程中计算每个节点的最优解。

### 代码实现

```java
public static int rob(TreeNode root){
		f(root);
		return Math.max(yes,no);
	}

	// 全局变量,完成了X子树的遍历,返回之后
	// yes变成,X子树在偷头节点的情况下,最大的收益
	public static int yes;

	// 全局变量,完成了X子树的遍历,返回之后
	// no变成,X子树在不偷头节点的情况下,最大的收益
	public static int no;
	public static void f(TreeNode root){
		if(root==null){
			yes = 0;
			no =0;// 边界条件
		}else{
			int y = root.val;  // 偷当前节点的收益,先加上节点值
			int n = 0;         // 不偷当前节点的收益

			f(root.left);      // 递归处理左子树
			y += no;           // 如果偷当前节点,只能累加左子树"不偷根"的收益
			n += Math.max(yes, no);  // 如果不偷当前节点,左子树可以自由选择

			f(root.right);     // 递归处理右子树
			y += no;           // 同样,偷当前节点只能累加右子树"不偷根"的收益
			n += Math.max(yes, no);  // 不偷当前节点,右子树自由选择
			yes = y;
			no = n;//更新全局状态
		}
	}
```
---
如果觉得有帮助，欢迎点赞、关注、转发~
