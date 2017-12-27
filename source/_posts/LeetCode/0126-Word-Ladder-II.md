---
title: 0126 Word Ladder II
date: 2017-12-27 22:31:31
categories: LeetCode
tags:
---

Given two words (beginWord and endWord), and a dictionary's word list, find all shortest transformation sequence(s) from beginWord to endWord, such that:

Only one letter can be changed at a time
Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
For example,

Given:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log","cog"]
Return
  [
    ["hit","hot","dot","dog","cog"],
    ["hit","hot","lot","log","cog"]
  ]
Note:
Return an empty list if there is no such transformation sequence.
All words have the same length.
All words contain only lowercase alphabetic characters.
You may assume no duplicates in the word list.
You may assume beginWord and endWord are non-empty and are not the same.


这题要求返回所有的路径，在之前的图论算法中，我们bfs 的同时用一个 iterator path 记录所有值。

这样子只能找到最短路径之一。

所以这里用dfs + level 的方式，找到所有path。

