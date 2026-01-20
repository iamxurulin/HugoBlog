---
title: "Leetcode2166-设计位集"
date: 2025-10-12 22:26:58
categories:
- 算法
tags:
- leetcode
draft: false
---

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/3d05d94e1d2b4b86bc623e32f852317e.png#pic_center)
在处理大规模布尔数组时,我们经常面临空间和时间效率的双重挑战。

如果用普通的 boolean 数组,每个元素至少占用 1 字节,当数据量达到百万级别时,内存开销会非常可观。

而位集合(Bitset)通过将每个布尔值压缩为一个比特位,可以将空间占用降低到原来的 1/32。

以下是一个支持延迟翻转优化的高效 Bitset 实现。

**代码**

```java
	class Bitset{

		private int[] set;//整形数组，用于存储位信息
		private final int size;//位集合的逻辑大小（用户视角的位数）
		private int zeros;//统计当前值为0的位的数量
		private int ones;//统计当前值为1的位的数量
		private boolean reverse;//反转标志

		//构造函数
		public Bitset(int n){
			set = new int[(n+31)/32];
			size = n;
			zeros = n;
			ones = 0;
			reverse = false;
		}

		public void fix(int i){
			int index = i/32;
			int bit = i%32;
			if(!reverse){
				//正常模式reverse=false，将0改为1
				if((set[index]&(1<<bit))==0){
					zeros--;
					ones++;
					set[index]|=(1<<bit);
				}
			}else{
				//反转模式reverse=true，将1改为0
				if((set[index]&(1<<bit))!=0){
					zeros--;
					ones++;
					set[index]^=(1<<bit);
				}
			}
		}

		public void unfix(int i){
			int index = i/32;
			int bit = i%32;
			if(!reverse){
				//正常模式reverse=false，将1改为0
				if((set[index]&(1<<bit))!=0){
					ones--;
					zeros++;
					set[index]^=(1<<bit);
				}
			}else{
				//反转模式reverse=true，将0改为1
				if((set[index]&(1<<bit))==0){
					ones--;
					zeros++;
					set[index]|=(1<<bit);
				}
			}
		}

		//翻转所有位（0变1，1变0）
		public void flip(){
			reverse = !reverse;
			int tmp = zeros;
			zeros=ones;
			ones = tmp;
		}

		//检查是否全为1
		public boolean all(){
			return ones == size;
		}

		//检查是否至少有一个1
		public boolean one(){
			return ones>0;
		}

		//返回1的数量
		public int count(){
			return ones;
		}

		//将位集合转换为字符串表示
		public String toString(){
			StringBuilder builder = new StringBuilder();
			for(int i=0,k=0,number,status;i<size;k++){
				number = set[k];
				for(int j=0;j<32&&i<size;j++,i++){
					status = (number>>j)&1;
					status ^= reverse?1:0;
					builder.append(status);
				}
			}
			return builder.toString();
		}

	}

```

