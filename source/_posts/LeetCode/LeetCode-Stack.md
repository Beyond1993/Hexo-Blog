---
title: LeetCode-Stack
date: 2017-08-23 00:34:56
categories: LeetCode
tags: stack
---
stack 作为一个广泛运用的数据结构，在刷题中，一般可能要用到好几个stack，按照数组的正序，倒序进栈.

## 456 132 pattern
找到是否有132 pattern 的序列
这题可以在数组里回溯，O(n^3), 判断是否valid,对求一个递增序列，s1,s2,s3，先确定s1,再确定s2,再确定s3.
所以对于 s1,s2,s3, 先确定s3,再确定s2,再确定s1, 从后往前遍历,比栈顶元素小，则压栈。

## 439 Ternary Expression Parser
