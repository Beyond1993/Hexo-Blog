---
title: 0946 Validate Stack Sequences
date: 2020-05-18 01:30:42
categories: LeetCode
tags:
---

Given two sequences pushed and popped with distinct values, return true if and only if this could have been the result of a sequence of push and pop operations on an initially empty stack.

Example 1:

Input: pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
Output: true
Explanation: We might do the following sequence:
push(1), push(2), push(3), push(4), pop() -> 4,
push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
Example 2:

Input: pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
Output: false
Explanation: 1 cannot be popped before 2.

中文意思:
给两个 int 数组 pushed, poped, 能否 通过一个empty 的stack 从pushed 变成 popped
数组里没有重复元素

