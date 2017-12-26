---
title: Top-K
date: 2017-12-17 07:40:31
categories: Algorithm
tags:
---

为什么Top-K 问题这么重要，因为在实际的工作中，很可能就是要取top k。

先不说top k个，就说第K个。

解法一：
先排序,再直接按顺序找到第K个.

解法二：

维护一个size 为 k 的heap，

解法三:

Quick selecy

解法四:

Intro select

Intro select = quick select + Median of medians

Median of medians 就是 pivot 选择的优化方法。


quick select 的平均时间复杂度是 linear-time, 但是最坏是 quadratic time。

但是 Intro select 可以做到最坏的时间复杂度也是 linear-time 




