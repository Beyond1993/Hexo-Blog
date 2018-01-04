---
title: LeetCode Best Time to Buy and Sell Stock
date: 2018-01-03 18:41:26
categories: LeetCode-Index
tags:
---

买卖股票的问题，一直没有找到一个统一的架构
直到:
https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/discuss/54114

https://discuss.leetcode.com/topic/107998/most-consistent-ways-of-dealing-with-the-series-of-stock-problems

题目: 给出一个数组代表每天的股票价格，然后求出最大收益。

思想：最大收益决定于我们要计算多少天，和最多能做多少次交易

这样子我们就得到一个状态 T[i][j] 表示 0 to i-th 天 最多 j 次交易的最大收益。

这样子的话我们可以得到很多子问题 T[i-1][k], T[i][k-1], T[i-1][k-1]

**题外话,对于这种DP 一开始想想子问题，再想暴力解, 其实DP 最难的就是这个构造多维空间的地方，有点像ml 里构造多维特征空间，一开始要充分的理解这题，抓住有用信息，这里的信息就是指的是变量，然后构造解空间**

好，在第i 天，我们可以使用哪些操作: buy, sell, rest


hold[i][j] 表示 maximum profit with at most j transaction for 0 to i-th day

unhold[i][j] = Math.max(hold[i-1][j-1]+prices[i],unhold[i-1][j])

121. Best Time to Buy and Sell Stock
122. Best Time to Buy and Sell Stock II
123. Best Time to Buy and Sell Stock III
188. Best Time to Buy and Sell Stock IV
309. Best Time to Buy and Sell Stock with Cooldown
714. Best Time to Buy and Sell Stock with Transaction Fee

case I: k = 1

```java
public int maxProfit(int[] prices) {
    int T_i10 = 0, T_i11 = Integer.MIN_VALUE;
        
    for (int price : prices) {
        T_i10 = Math.max(T_i10, T_i11 + price);
        T_i11 = Math.max(T_i11, -price);
    }
        
    return T_i10;
}
```
case II: k = +Infinity
```java
public int maxProfit(int[] prices) {
    int T_ik0 = 0, T_ik1 = Integer.MIN_VALUE;
    
    for (int price : prices) {
        int T_ik0_old = T_ik0;
        T_ik0 = Math.max(T_ik0, T_ik1 + price);
        T_ik1 = Math.max(T_ik1, T_ik0_old - price);
    }
    
    return T_ik0;
}
```

Case II: k = 2
```java
public int maxProfit(int[] prices) {
    int T_i10 = 0, T_i11 = Integer.MIN_VALUE, T_i20 = 0, T_i21 = Integer.MIN_VALUE;
        
    for (int price : prices) {
        T_i20 = Math.max(T_i20, T_i21 + price);
        T_i21 = Math.max(T_i21, T_i10 - price);
        T_i10 = Math.max(T_i10, T_i11 + price);
        T_i11 = Math.max(T_i11, -price);
    }
        
    return T_i20;
}
```

Case IV : k is arbitrary
```java
public int maxProfit(int k, int[] prices) {
    if (k >= prices.length >>> 1) {
        int T_ik0 = 0, T_ik1 = Integer.MIN_VALUE;
    
        for (int price : prices) {
            int T_ik0_old = T_ik0;
            T_ik0 = Math.max(T_ik0, T_ik1 + price);
            T_ik1 = Math.max(T_ik1, T_ik0_old - price);
        }
        
        return T_ik0;
    }
        
    int[] T_ik0 = new int[k + 1];
    int[] T_ik1 = new int[k + 1];
    Arrays.fill(T_ik1, Integer.MIN_VALUE);
        
    for (int price : prices) {
        for (int j = k; j > 0; j--) {
            T_ik0[j] = Math.max(T_ik0[j], T_ik1[j] + price);
            T_ik1[j] = Math.max(T_ik1[j], T_ik0[j - 1] - price);
        }
    }
        
    return T_ik0[k];
}
```

Case V: k = +Infinity but with cooldown

```java
public int maxProfit(int[] prices) {
    int T_ik0_pre = 0, T_ik0 = 0, T_ik1 = Integer.MIN_VALUE;
    
    for (int price : prices) {
        int T_ik0_old = T_ik0;
        T_ik0 = Math.max(T_ik0, T_ik1 + price);
        T_ik1 = Math.max(T_ik1, T_ik0_pre - price);
        T_ik0_pre = T_ik0_old;
    }
    
    return T_ik0;
}
```

Case VI: k = +Infinity but with transaction fee
```java
public int maxProfit(int[] prices, int fee) {
    int T_ik0 = 0, T_ik1 = Integer.MIN_VALUE;
    
    for (int price : prices) {
        int T_ik0_old = T_ik0;
        T_ik0 = Math.max(T_ik0, T_ik1 + price);
        T_ik1 = Math.max(T_ik1, T_ik0_old - price - fee);
    }
        
    return T_ik0;
}
```

```java
public int maxProfit(int[] prices, int fee) {
    long T_ik0 = 0, T_ik1 = Integer.MIN_VALUE;
    
    for (int price : prices) {
        long T_ik0_old = T_ik0;
        T_ik0 = Math.max(T_ik0, T_ik1 + price - fee);
        T_ik1 = Math.max(T_ik1, T_ik0_old - price);
    }
        
    return (int)T_ik0;
}
```
