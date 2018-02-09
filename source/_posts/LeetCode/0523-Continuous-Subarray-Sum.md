---
title: 0523 Continuous Subarray Sum
date: 2018-02-08 20:39:33
categories: LeetCode
tags:
---

Given a list of non-negative numbers and a target integer k, write a function to check if the array has a continuous subarray of size at least 2 that sums up to the multiple of k, that is, sums up to n*k where n is also an integer.

Example 1:
Input: [23, 2, 4, 6, 7],  k=6
Output: True
Explanation: Because [2, 4] is a continuous subarray of size 2 and sums up to 6.
Example 2:
Input: [23, 2, 6, 4, 7],  k=6
Output: True
Explanation: Because [23, 2, 6, 4, 7] is an continuous subarray of size 5 and sums up to 42.
Note:
The length of the array won't exceed 10,000.
You may assume the sum of all the numbers is in the range of a signed 32-bit integer.

这题实在是太机智了。

利用的原理是 如果 sum2 % k == sum1 % k, 则 sum2 - sum1 == n * K。

如果 k = 6, 1 ,7, 13  模 6 的结果都是1，则他们相差了 6 的倍数.

