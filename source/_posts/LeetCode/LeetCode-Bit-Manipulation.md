---
title: LeetCode-Bit-Manipulation
date: 2017-10-16 07:07:21
categories: LeetCode-Index
tags:
---

303Range Sum Query - Immutable   29.3%Easy

304Range Sum Query 2D - Immutable   24.9%Medium

307Range Sum Query - Mutable   20.4%Medium

308Range Sum Query 2D - Mutable   

这四道题是很好的一个系列题．从一维到二维，从矩阵到树 从0(n^2) 到 O(logn)， 正是计算机优化的方向．



303 一维数组

304 二维数组



307 segment tree

Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.

The update(i, val) function modifies nums by updating the element at index i to val.

Example:

Given nums = [1, 3, 5]

sumRange(0, 2) -> 9
update(1, 2)
sumRange(0, 2) -> 8


reference:http://blog.csdn.net/metalseed/article/details/8039326

线段树，又称区间树， 在区间统计问题上，如区间动态查询，能达到较快速度。

节点中包含了 start end, 还有sum, max, min 等信息。

一般线段树空间是数组的四倍？？？











308 二进制索引树（树状数组）



能用树状数组解决的题基本都能用segment tree 解决， 但是反之不行。

树状数组效率比线段树要高。


http://blog.csdn.net/v_july_v/article/details/6685962

Bit map

是用来在大数据情况下，节省内存的最常用方式。

比如利用bit map sort, 基本就是类似于桶排序。 但是将每个元素的内存从一个Integer 压缩到 一个 Bit。



http://blog.csdn.net/v_july_v/article/details/6685894

Bloom Filter 布隆过滤器 是  bit map 的拓展。




