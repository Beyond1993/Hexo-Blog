---
title: 0416-Partition-Equal-Subset-Sum
date: 2017-10-16 05:24:29
categories: LeetCode
tags:
---




这题的题意是给出一个数组, [1,5,11,5]

能否找出一个patition, 使得两个集合和相等．



这题是true, ［１．５，５］　和　［１１］



这题就是在数组中找出几个数字，使其和为给定值．

这题可以转化成　0,  1 背包问题．







１：能否被等分．

２：给出一组解



　拓展有三等分，四等分，ｎ等分．

Balanced Partition of Array



先看二等分问题

d[i][j] 表示前i个数字．能否组成和为j.

dp[i][j] = dp[i-1][j] || dp[i][j - nums[i]



空间复杂度可以优化到一维.

dp[j] 



如果是三等分问题

http://www.dewen.net.cn/q/14871/%E8%A7%A3%E4%B8%89%E5%88%92%E5%88%86%E9%97%AE%E9%A2%98+3-partition+problem+%E7%9A%84%E6%80%9D%E8%B7%AF












