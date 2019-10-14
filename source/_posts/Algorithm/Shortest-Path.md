---
title: Shortest Path
date: 2019-10-14 04:28:41
categories: Algorithm
tags:
---


```txt    
                                                            
                                                           +--- 朴素 Dijkstra 算法 O(n ^2)
                                                           |
                                   +-----所有权边都是正数--+ 优化版的Dijkstra 算法 O(mlogn)
                                   |
         +------ 单源最短路径+-----+----存在负权边---------+Bellman-Ford O(mn)
         |                                                 |
最短路径 +                                                 +SPFA 一般O(m), 最坏O(nm)
         |
         + 多源汇对短路 Floyd 算法 O(n^3)

```
