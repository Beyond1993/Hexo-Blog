---
title: Dijkstra
date: 2018-02-06 07:56:41
categories: Algorithm
tags:
---

Dijkstra 算法

单源最短路径, 如果用负权重的话，很可能没有最短路径的.

1. 最简单的方法

就是用bfs, 不断搜索，每出队一个节点， 就更新邻居。比当前值小，就更新.

时间复杂度是 O(V^2), 因为最坏情况是一个完全图.

2. 二叉堆 （就是一般意义的堆)


用 priority queue 的好处不是heap pop 出来的一定是当前最小的.

而是有些路径根本不用去遍历。相当于一个剪枝的过程.


```text
        +--- node2 ---+
      1                2
     /                  \
node1 ---5---node3 --1-- node5
    \                    / 
      3                 1
       \ ----node4--1--/
```


如果用 pq的话， node2 出堆之后，就是node5 出堆, 然后紧接着把 node3 的distance 变成 4，这样就不会用 node1 --5-- node3 这条边去尝试了.
这种的时间复杂度是 (m + n)logn
