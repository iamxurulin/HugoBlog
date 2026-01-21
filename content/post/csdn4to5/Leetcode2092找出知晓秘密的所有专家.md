---
title: "Leetcode2092找出知晓秘密的所有专家"
date: 2026-01-04 19:53:26
categories:
- 算法
tags:
  - 数组
draft: false
---

![在这里插入图片描述](/images/ab39894e79da4c91a628e8377fd8e997-95e684e8.jpeg)
![在这里插入图片描述](/images/1c8f1936cbce433186c44978d3076e04-63623354.jpeg)
### 求解代码

```java
public static int MAXN = 100001;
	public static int[] father = new int[MAXN];
	public static boolean[] secret = new boolean[MAXN];

	public static void build(int n,int first){
		for(int i=0;i<n;i++){
			father[i]=i;
			secret[i]=false;
		}
		father[first]=0;
		secret[0]=true;
	}

	public static int find(int i){
		if(i!=father[i]){
			father[i]=find(father[i]);
		}
		return father[i];
	}

	public static void union(int x,int y){
		int fx = find(x);
		int fy = find(y);

		if(fx!=fy){
			father[fx]=fy;
			secret[fy]|=secret[fx];
		}
	}

	public static List<Integer> findAllPeople(int n,int[][] meetings,int first){
		build(n, first);

		Arrays.sort(meetings,(a,b)->a[2]-b[2]);
		int m = meetings.length;
		for(int l=0,r;l<m;){
			r=l;
			while (r+1<m&&meetings[l][2]==meetings[r+1][2]) {
				r++;
			}

			for(int i=l;i<=r;i++){
				union(meetings[i][0], meetings[i][1]);
			}

			for(int i=l,a,b;i<=r;i++){
				a=meetings[i][0];
				b=meetings[i][1];
				if(!secret[find(a)]){
					father[a]=a;
				}
				if(!secret[find(b)]){
					father[b]=b;
				}
			}
			l=r+1;
		}

		List<Integer> ans = new ArrayList<>();
		for(int i=0;i<n;i++){
			if(secret[find(i)]){
				ans.add(i);
			}
		}
		return ans;
	}
```

