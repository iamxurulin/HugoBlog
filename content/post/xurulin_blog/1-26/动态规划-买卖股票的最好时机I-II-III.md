---
title: "动态规划-买卖股票的最好时机I-II-III"
date: 2026-01-25 00:04:30
categories:
  - 算法
tags:
  - 动态规划
draft: false
---


![](/images/90374516d05f5567c118fdffac2fdecf-447e2a17.png)

### 求解代码
```java
public int maxProfit (int[] prices) {
        if(prices==null||prices.length<2){
            return 0;
        }

        int n = prices.length;
        int[][] dp = new int[n][2];
        dp[0][0]=0;
        dp[0][1]=-prices[0];
        for(int i=1;i<n;i++){
            dp[i][0]=Math.max(dp[i-1][0], dp[i-1][1]+prices[i]);
            dp[i][1]=Math.max(dp[i-1][1],-prices[i]);
        }
        return dp[n-1][0];
    }
```

### ![](/images/49b3ead3292e8c086ec6fdb78e4f6993-8fcdb857.png)
![](/images/af57ac75bc839ea21a9dfbd71b93d5de-1923e9dc.png)



### 求解代码
```java
public int maxProfit(int[] prices) {
        if ( prices == null || prices.length < 2 ) {
            return 0;
        }

        int n = prices.length;
        int[][] dp = new int[n][2];
        dp[0][0] = 0;
        dp[0][1] = -prices[0];
        for (int i = 1; i < n; i++) {
            dp[i][0] = Math.max(dp[i - 1][0], dp[i - 1][1] + prices[i]);
            dp[i][1] = Math.max(dp[i - 1][1], dp[i - 1][0] - prices[i]);
        }
        return dp[n - 1][0];
    }
```

### 小贴士
和上面的类型（一）不一样的是，这题可以进行多次交易，代码上的体现就是：

![](/images/7b7df3201c05f510ed788a9f3cc344b4-21fbe523.png)

![](/images/9d8027488c0ca709a29c25fcecbd856a-d5f932cc.png)

![](/images/0cf98583a2aa0383b122cbc7a026e60b-dc48ea2b.png)

### 求解代码
```java
public int maxProfit(int[] prices) {
        return maxProfit_k(prices, 2);
    }

    public int maxProfit_k(int[] prices, int k) {
        if (prices == null || prices.length < 2) {
            return 0;
        }

        int n = prices.length;
        int[][][] dp = new int[n][k + 1][2];
        for (int j = 0; j <= k; j++) {
            dp[0][j][0] = 0;
            dp[0][j][1] = -prices[0];
        }

        for (int i = 1; i < n; i++) {
            for (int j = 1; j <= k; j++) {
                dp[i][j][0] = Math.max(dp[i - 1][j][0], dp[i - 1][j][1] + prices[i]);
                dp[i][j][1] = Math.max(dp[i - 1][j][1], dp[i - 1][j - 1][0] - prices[i]);
            }

        }
        return dp[n - 1][k][0];
    }
```

### 小贴士
说说三维`DP`的定义：

`dp[i][j][0]`：第`i`天，最多完成了`j`次交易，不持有股票的最大利润；

`dp[i][j][1]`：第`i`天，最多完成了`j`次交易，持有股票的最大利润；








