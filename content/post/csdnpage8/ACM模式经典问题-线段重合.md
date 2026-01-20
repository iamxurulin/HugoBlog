---
title: "ACM模式经典问题：线段重合"
date: 2025-10-07 12:26:33
categories:
- 算法
tags:
- leetcode
draft: false
---

在处理区间问题时，我们经常会遇到需要找出“最多有多少个事件同时发生”的场景。

比如会议室的最大占用数、资源的最大并发访问量等等。

本文分析一道经典的线段重合问题。

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/6b23b0e88cbe49288d44cd05d9f8054d.png#pic_center)
### 代码逻辑
#### 输入输出
```java
public static void main(String[] args) throws IOException {
        // 输入
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StreamTokenizer in = new StreamTokenizer(br);
        // 输出
        PrintWriter out = new PrintWriter(new OutputStreamWriter(System.out));

        // 多组输入：直到读取到文件末尾
        while (in.nextToken() != StreamTokenizer.TT_EOF) {
            // 读取线段总数n
            n = (int) in.nval;
            // 读取n条线段的开始和结束位置
            for (int i = 0; i < n; i++) {
                in.nextToken(); // 读取开始位置
                line[i][0] = (int) in.nval;
                in.nextToken(); // 读取结束位置
                line[i][1] = (int) in.nval;
            }
            // 计算最大重合数并输出
            out.println(compute());
        }

        // 关闭流
        out.flush();
        out.close();
        br.close();
    }
```
#### compute 方法

```java
    public static int compute() {
        size = 0; // 每次计算前重置堆大小
        // 按线段的「开始位置」升序排序
        Arrays.sort(line, 0, n, (a, b) -> a[0] - b[0]);

        int ans = 0; // 记录最大重合数
        // 遍历每条线段，维护堆并计算重合数
        for (int i = 0; i < n; i++) {
            int curStart = line[i][0]; // 当前线段的开始位置
            int curEnd = line[i][1];   // 当前线段的结束位置

            // 移除堆中「已结束」的线段（堆顶是最早结束的，先判断它）
            // 堆不为空，且堆顶的结束位置 ≤ 当前线段开始位置 → 不重合，弹出
            while (size > 0 && heap[0] <= curStart) {
                pop();
            }

            // 把当前线段的结束位置加入堆（当前线段开始参与重合）
            add(curEnd);

            // 更新最大重合数（堆的大小就是当前重合数）
            ans = Math.max(ans, size);
        }
        return ans;
    }

```
#### 小根堆的实现

```java
// 新元素向上调整
    public static void add(int x) {
        // 新元素先放到堆的最后一位
        heap[size] = x;
        int i = size++; // i是新元素的初始索引

        // 向上调整：和父节点比较，比父节点小就交换
        // 父节点索引 = (i-1)/2（整数除法，自动向下取整）
        while (heap[i] < heap[(i - 1) / 2]) {
            swap(i, (i - 1) / 2);
            i = (i - 1) / 2; 比较
        }
    }

    // 堆顶（最小值）移除，向下调整
    public static void pop() {
        // 堆顶（索引0）和堆的最后一位元素交换
        swap(0, --size); // 交换后，size-1 → 堆顶元素被“移除”

        int i = 0; // 从堆顶开始向下调整
        int l = 1; // 左孩子索引 = 2*i + 1

        // 向下调整
        while (l < size) {
            // 选左右孩子中「更小」的那个（右孩子存在且更小才选右）
            int best = (l + 1 < size && heap[l + 1] < heap[l]) ? l + 1 : l;

            // 比较“最小孩子”和当前节点
            best = (heap[best] < heap[i]) ? best : i;
            if (best == i) {
                break;
            }

            // 交换当前节点和最优孩子，继续向下调整
            swap(i, best);
            i = best;       
            l = i * 2 + 1;  
        }
    }

```
**完整代码**

链接：https://pan.quark.cn/s/7ec0540d754b
提取码：iMn8
