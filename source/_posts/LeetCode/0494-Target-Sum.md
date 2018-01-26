---
title: 0494 Target Sum
date: 2018-01-26 00:01:37
categories: LeetCode
tags:
---

You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.

Find out how many ways to assign symbols to make sum of integers equal to target S.

Example 1:
Input: nums is [1, 1, 1, 1, 1], S is 3. 
Output: 5
Explanation: 

-1+1+1+1+1 = 3
+1-1+1+1+1 = 3
+1+1-1+1+1 = 3
+1+1+1-1+1 = 3
+1+1+1+1-1 = 3

There are 5 ways to assign symbols to make the sum of nums be target 3.
Note:
The length of the given array is positive and will not exceed 20.
The sum of elements in the given array will not exceed 1000.
Your output answer is guaranteed to be fitted in a 32-bit integer.

这题第一反应就是二维DP

dp[i][j] 表示遍历到第i个数, sum 为 j 的种类，但是这题的j 的范围不能简单的设成0 ~ S. 而是 sum(-nums)  ~ sum(nums)之间. 这样字搜索的空间复杂度就很大，相当于把sum 的所有种类都要遍历到。


