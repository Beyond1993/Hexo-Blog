---
title: 0987 Vertical Order Traversal of a Binary Tree
date: 2020-06-11 09:16:29
categories: LeetCode
tags:
---

一家公司的面试题

Given a binary tree, return the vertical order traversal of its nodes values.

For each node at position (X, Y), its left and right children respectively will be at positions (X-1, Y-1) and (X+1, Y-1).

Running a vertical line from X = -infinity to X = +infinity, whenever the vertical line touches some nodes, we report the values of the nodes in order from top to bottom (decreasing Y coordinates).

If two nodes have the same position, then the value of the node that is reported first is the value that is smaller.

Return an list of non-empty reports in order of X coordinate.  Every report will have a list of values of nodes.


关于每一列的重叠个数， 是一个杨辉三角, Pascal's Triangle
```txt
        1
     1     1
   1    2   1
  1  3    3  1
1  4   6   4  1
``` 

第n行的m个数可表示为 C(n-1，m-1)，即为从n-1个不同元素中取m-1个元素的组合数。
第n 行和 2^(n-1)
