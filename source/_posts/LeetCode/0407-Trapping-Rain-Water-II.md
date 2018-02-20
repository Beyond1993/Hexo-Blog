---
title: 0407 Trapping Rain Water II
date: 2018-02-20 00:41:31
categories: LeetCode
tags:
---

Given an m x n matrix of positive integers representing the height of each unit cell in a 2D elevation map, compute the volume of water it is able to trap after raining.

Note:
Both m and n are less than 110. The height of each unit cell is greater than 0 and is less than 20,000.

Example:

Given the following 3x6 height map:
[
  [1,4,3,1,3,2],
  [3,2,1,3,2,4],
  [2,3,3,2,3,1]
]

Return 4.

![](https://leetcode.com/static/images/problemset/rainwater_empty.png)

The above image represents the elevation map [[1,4,3,1,3,2],[3,2,1,3,2,4],[2,3,3,2,3,1]] before the rain.

![](https://leetcode.com/static/images/problemset/rainwater_fill.png)

After the rain, water is trapped between the blocks. The total volume of water trapped is 4.

思路
https://aaronice.gitbooks.io/lintcode/content/heap/trapping_rain_water_ii.html

就是说，找到一点，计算周围4点的水量，再标记过已访问过


初始化的四周的点
