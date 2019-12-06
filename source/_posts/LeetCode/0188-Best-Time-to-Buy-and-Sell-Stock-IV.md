---
title: 0188 Best Time to Buy and Sell Stock IV
date: 2018-01-03 05:40:11
categories: LeetCode
tags:
---


假设你有一个数组，它的第i个元素是一支给定的股票在第i天的价格。
设计一个算法来找到最大的利润。你最多可以完成 k 笔交易。

给定价格 = [4,4,6,1,1,4,2,5], 且 k = 2, 返回 6.

你不可以同时参与多笔交易(你必须在再次购买前出售掉之前的股票)

前面那个两次买卖问题，其实是一个划分问题，直接找一个最优的划分 [0...i] [i... n-1]

来回扫两遍就ok, 但这次就是划分出K个。

https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/discuss/54114

这种问题，就是要找到generate 的解法


https://github.com/mission-peace/interview/blob/master/src/com/interview/dynamic/StockBuySellKTransactions.java


```java
public int maxProfitSlowSolution(int prices[], int K) {
   if (K == 0 || prices.length == 0) {
      return 0;
   }   
   int T[][] = new int[K+1][prices.length];
   for (int i = 1; i < T.length; i++) {
       for (int j = 1; j < T[0].length; j++) {
           int maxVal = 0;
           for (int m = 0; m < j; m++) {
               maxVal = Math.max(maxVal, prices[j] - prices[m] + T[i-1][m]);
       }    
       T[i][j] = Math.max(T[i][j-1], maxVal);
   }
    }
printActualSolution(T, prices);
return T[K][prices.length - 1];
}
```
