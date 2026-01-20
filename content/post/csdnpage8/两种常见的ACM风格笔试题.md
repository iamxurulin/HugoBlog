---
title: "两种常见的ACM风格笔试题"
date: 2025-09-30 21:27:03
categories:
- 算法
tags:
  - 数组
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/97697dcb81c94d7c84c7b13fc6ceb4da.png#pic_center)
在算法笔试中，一般有两种风格，一种是填函数风格，可以粗暴地理解为Leetcode中提交的风格，另一种是ACM风格，可以认为是要自己写输入输出的风格，比如华为笔试的风格。

如果是ACM风格，尽量不要使用Scanner、System.out，因为他们的IO效率非常慢。

ACM风格也有两种常见的形式，一种是给定数据规模，另一种是未给定数据规模。


## 给定数据规模
这道子矩阵的最大累加和问题是一道典型的给定数据规模的题目。
### 代码

```java
	public static void main(String[] args) throws IOException{
		//将文件中的内容load进内存中
		BufferedReader br  = new BufferedReader(new InputStreamReader(System.in));
		//一个一个读数字
		StreamTokenizer in = new StreamTokenizer(br);
		PrintWriter out = new PrintWriter(new OutputStreamWriter(System.out));
		//文件没有结束就继续
		while(in.nextToken()!=StreamTokenizer.TT_EOF){
			int n = (int)in.nval;
			in.nextToken();
			int m = (int)in.nval;
			int[][] mat = new int[n][m];
			for(int i=0;i<n;i++){
				for(int j = 0;j<m;j++){
					in.nextToken();
					mat[i][j]=(int)in.nval;
				}
			}
			out.println(maxSumSubmatrix(mat,n,m));
		}
		out.flush();
		br.close();
		out.close();
	}
	public static int maxSumSubmatrix(int[][] mat,int n,int m){
		int max = Integer.MIN_VALUE;
		for (int i=0;i<n;i++){
			int[] arr = new int[m];
			for(int j=i;j<n;j++){
				for(int k=0;k<m;k++){
					arr[k]+=mat[j][k];
				}
				max = Math.max(max,maxSumSubarray(arr,m));
			}
		}
		return max;
	}

	public static int maxSumSubarray(int[] arr,int m){
		int max = Integer.MIN_VALUE;
		int cur = 0;
		for(int i=0;i<m;i++){
			cur+=arr[i];
			max=Math.max(max,cur);
			cur = cur<0?0:cur;
		}
		return max;
	}
```

## 未给定数据规模
对于没有给定数据规模的ACM风格的笔试题，其实这个时候你想用Scanner也用不了，因为你不知道用户会输入几个数字，所以这个时候可以考虑按行读取。

代码如下：

```java

	// 静态变量：用于存储读取的行和分割后的数字数组
	public static String line;
	public static String[] parts;
	public static int sum;

	public static void main(String[] args) throws IOException {
		// 1. 创建输入流：从标准输入（键盘）读取数据
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		// 2. 创建输出流：向标准输出（控制台）写入数据
		PrintWriter out = new PrintWriter(new OutputStreamWriter(System.out));

		// 3. 循环读取每行数据，直到输入结束（如 Ctrl+D 或文件末尾）
		while ((line = in.readLine()) != null) {
			// 4. 按空格分割当前行，得到数字字符串数组
			parts = line.split(" ");
			sum = 0; // 重置求和变量

			// 5. 遍历数组，将每个字符串转换为整数并累加
			for (String num : parts) {
				sum += Integer.valueOf(num);
			}

			// 6. 输出当前行的求和结果
			out.println(sum);
		}

		// 7. 资源清理：刷新输出流并关闭所有流
		out.flush();
		in.close();
		out.close();
	}

```
**PS**

1.BufferedReader 和 PrintWriter 内部维护缓冲区，减少了直接操作磁盘或控制台的次数（IO 操作是程序性能瓶颈之一），尤其在处理大量数据时优势明显。

2.循环读取 line != null 的逻辑适用于各种场景（如读取文件、网络流、控制台输入），只需替换输入流的来源即可复用代码。
