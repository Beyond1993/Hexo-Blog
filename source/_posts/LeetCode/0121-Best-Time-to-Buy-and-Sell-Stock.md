---
title: 0121 Best Time to Buy and Sell Stock
date: 2018-01-01 02:07:26
categories: LeetCode
tags:
---


Say you have an array for which the ith element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Example 1:
Input: [7, 1, 5, 3, 6, 4]
Output: 5

max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)
Example 2:
Input: [7, 6, 4, 3, 1]
Output: 0

In this case, no transaction is done, i.e. max profit = 0.

[7, 1, 5, 3, 6, 4],只允许买卖一次，求最大收益
保存最小值
一边扫描，一边更新最小值，一边用当前值减最小值
更新最大值


```java
class Solution {
    public int maxProfit(int[] prices) {
        int max = 0;
        int maxCurr = 0;
        for (int i=1;i<prices.length;i++) {
            maxCurr = Math.max(0, maxCurr + prices[i] - prices[i-1]);
            max = Math.max(max,maxCurr);
        }
       return max;
    }
}
```

```java
class Solution {
    public int maxProfit(int[] prices) {
        int min = Integer.MAX_VALUE;
        int res = 0;
        for (int i = 0; i < prices.length; i++) {
            min = Math.min(min, prices[i]);
            res = Math.max(res, prices[i] - min);
        }
        return res;
    }
}
```

```java
public int maxProfit(int[] prices) {
    if (prices.length == 0) {
        return 0;
    }
    int low = prices[0];
    int re = 0;
    for (int i = 0; i < prices.length; i++) {
        if (prices[i] < low) {
            low = prices[i];
        } else if (prices[i] - low > re) {
            re = prices[i] - low;
        }
    }
    return re;
}
```


similar question:

http://47.113.101.198/2018/01/01/LeetCode/0122-Best-Time-to-Buy-and-Sell-Stock-II/


