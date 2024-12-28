---
title: 0122 Best Time to Buy and Sell Stock II
date: 2018-01-01 03:22:00
categories: LeetCode
tags:
---


Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times). However, you may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).


这次股票可以买卖任意多次，但是买过之后只能卖，不能连续买两次 求最大收益
任意多次求最大收益，利用了单调增序列，差值不变性质
如1,2,3，最大收益为3-1=2，和2-1+3-2是一标的

所以，只要prices[i+1]>prices[i]:sum=prices[i+1]-prices[i];

```java
public int maxProfit(int[] prices) {
  int sum = 0;
  for (int i = 0; i < prices.length -1; i++) {
    if (prices[i+1] > prices[i]) {
      sum += prices[i+1] - prices[i];
    }
    return sum;
  }
}
```
similar question
http://47.113.101.198/2018/01/01/LeetCode/0123-Best-Time-to-Buy-and-Sell-Stock-III/
