---
title: 0090 Subsets II
date: 2017-12-24 00:01:46
categories: LeetCode
tags:
---

Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

For example,
If nums = [1,2,2], a solution is:

[
  [2],
  [1],
  [1,2,2],
  [2,2],
  [1,2],
  []
]

有重复元素，这里的重复元素的处理和permutation II 中的处理不同，Permutation 去重是 当前元素等于上一个元素，然后上个元素没有访问过，continue

这里的是 当前元素 等于 上一个元素， i > pos, 如果不加 i > pos, 最后1,2,2]的结果可能就是 [1,2], 而不会有[1,2,2] 出现
