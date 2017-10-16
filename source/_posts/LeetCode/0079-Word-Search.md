---
title: 0079-Word-Search
date: 2017-10-16 07:28:47
categories: LeetCode
tags:
---

Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

For example,
Given board =

[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
word = "ABCCED", -> returns true,
word = "SEE", -> returns true,
word = "ABCB", -> returns false.



这是一题非常非常经典的矩阵回溯搜索的题。可以总结出一套递归搜索模板。



思路：先遍历矩阵，找到和字符串头相同的元素，开始回溯搜索。


