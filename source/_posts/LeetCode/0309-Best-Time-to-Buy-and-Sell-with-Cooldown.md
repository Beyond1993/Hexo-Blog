---
title: 0309 Best Time to Buy and Sell with Cooldown
date: 2018-01-03 05:41:18
categories: LeetCode
tags:
---

Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times) with the following restrictions:

You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).
After you sell your stock, you cannot buy stock on next day. (ie, cooldown 1 day)
Example:

prices = [1, 2, 3, 0, 2]
maxProfit = 3
transactions = [buy, sell, cooldown, buy, sell

增加条件，在卖出股票后，至少隔一天再买。


分两种情况,

前一天卖了，
前一天没卖

我写的答案

```java
class Solution {
    public int maxProfit(int[] prices) {
        if (prices.length <= 1) return 0;
        int n = prices.length;
        
        int[] buy = new int[n];
        int[] sell = new int[n]; 
       
        buy[0] = -prices[0];
        buy[1] = Math.max(-prices[0], -prices[1]);
        
        sell[0] = 0;
        sell[1] = prices[1] - prices[0];
        
        for (int i = 2; i < prices.length; i++) {
            buy[i]  = Math.max(sell[i-2] - prices[i], buy[i-1]);
            sell[i] = Math.max(buy[i-1] + prices[i], sell[i-1]);
        }
        
        return Math.max(0, Math.max(buy[n-1], sell[n-1]));
    }
}
```



