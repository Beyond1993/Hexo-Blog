---
title: Median-of-Two-Sorted-Arrays
date: 2017-10-16 07:39:04
categories: LeetCode
tags:
---

先解k th 的问题，求第K小的数。



二分法的本质，取第K小 ===转化===> 舍掉k / 2 个数后，取第 k - k / 2 小



1.对于 [1,2,5], [3,4], k = 3, k / 2 =1, k - k/2 = 2, number[A_start] < num[B_start]

等价于去掉A中的第一个后，再求第二小的数。

2. [2,3,4,5] [1] k = 4, k / 2

这种情况，应该删除小的。 B的前两个，然而B只有一个，所以是先去掉A的前两个。

3.[3,4,5] [1,2] k = 5, k - k / 2 = 3, 去掉两个求第3个了, k = 3

去掉 B的1，2， A_start = 0 + 2 = 2, 直接返回A的第3个 A_start + 3 - 1