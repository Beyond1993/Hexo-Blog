---
title: Dijkstra
date: 2018-02-06 07:56:41
categories: Algorithm
tags:
---

Dijkstra 算法

单源最短路径

用 priority queue 的好处不是heap pop 出来的一定是当前最小的.

而是有些路径根本不用去遍历。相当于一个剪枝的过程.


```text
     /^ 2
   4
  /
1  --5--> 3
  \ 
   3
    \V 4
```

