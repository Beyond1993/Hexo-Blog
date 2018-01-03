---
title: LeetCode Best Time to Buy and Sell Stock
date: 2018-01-03 18:41:26
categories: LeetCode
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

**题外话,对于这种DP 一开始想想子问题，再想暴力解**


hold[i][j] 表示 maximum profit with at most j transaction for 0 to i-th day


hold[i][j] = Math.max(unho


