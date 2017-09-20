---
title: Graph-Topological-Sort
date: 2017-09-17 00:32:23
categories: Algorithm
tags:
---

Topological Sort

拓扑排序实在是太经典的图算法啦。其应用场景及其广泛。

首先拓扑排序针对的是点之间的先后关系。

算法步骤：

step1: 遍历先后关系（有向边）， 构建邻接表，并计算每个点的入度
step2: 将入度为0的点存入队列
step3: 将入度为0的点出队，其所有的邻接点入度减一，若入度为0，入队。

LeetCode 207 Course Schedule
问能否拓排序。

LeetCode 210 Course Schedule II

拓扑排序的顺序。


