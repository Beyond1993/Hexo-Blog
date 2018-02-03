---
title: 324 Wiggle Sort II
date: 2018-02-07 02:23:30
categories: LeetCode
tags:
---


题目描述

Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example:
(1) Given nums = [1, 5, 1, 1, 6, 4], one possible answer is [1, 4, 1, 5, 1, 6]. 
(2) Given nums = [1, 3, 2, 2, 3, 1], one possible answer is [2, 3, 1, 3, 1, 2].

Note:
You may assume all input has valid answer.

Follow Up:
Can you do it in O(n) time and/or in-place with O(1) extra space?


这题很有意思， 在wiggle sort I 中，奇偶之间是大于等于或者小于等于的，这个follow up 直接就去掉了等于号。

那我们第一反应就是能不能还想上一题一样，直接分奇偶呢？

最简单的方法就是直接把上一题的代码放进来跑一遍

Input:
[1,2,2,1,2,1,1,1,1,2,2,2]
Output:
[1,2,1,2,1,2,1,1,1,2,2,2]
Expected:
[1,2,1,2,1,2,1,2,1,2,1,2]


处理不了重复值。

那这个问题怎处理？ < 交换， 换成 <= 交换？ 可它是相邻重复值啊，不管 交不交换都没用。

排序，排序，排序，说到排序，其实也就是那几种经典排序的变种。

选择？ 冒泡？ 归并？ 好像都不行，快排！！

选一个中点，比这个值大的都放在奇数index 的slot 里，比这个值小的放在偶数index 的 slot 里，这样子不就保证奇树位置上的值比偶数位置上的值大了？


其实这题leetCode 里的那个java 写法，用了一个heap， 来求Kth element。

问题是这样求第k大元素空间复杂度并不是最优解，也就是说不是O(1)

所以说C++ 那版用 nth_element 的复杂度是O(1). 因为 nth_element 使用Introselect 来实现的

[refer] 
