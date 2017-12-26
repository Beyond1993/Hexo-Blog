---
title: Graph Stroage
date: 2017-12-26 06:06:28
categories: Algorithm
tags:
---



存储方法又可以分为点存储，和边存储

比如clone graph, 用的就是点存储。
```java
class UndirectedGraphNode {
      int label;
      List<UndirectedGraphNode> neighbors;
      UndirectedGraphNode(int x) {
          label = x;
          neighbors = new ArrayList<UndirectedGraphNode>(); }
  };
```

[207 Course Schedule]
这种拓扑排序，用的是 int[][] 存储一个边

存储方法：
1  邻接矩阵： n 阶方阵，无向图是对称矩阵，有向图行是出度，列是入度
2  邻接表： 可用vector, linked list, arraylist, set, priorityqueue.
3  十字链表:
4  [前向星](http://blog.csdn.net/qq_30331643/article/details/68621435):  向前星>是一个数组记录以某个点为起点的边，里面的element 是 Edge { start, end }, 按照先start,后end 拍好序，
再用 len[i]来记录所有以i为起点的边在数组中的存储长度,head[i]记录以i为边集在数组>中的第一个存储位置.
 所以出度为0的边，是不能存进数组的。
5  [链式前向星](http://jzqt.github.io/2015/07/21/ACM%E5%9B%BE%E8%AE%BA%E4%B9%8B%E5%AD%98%E5%9B%BE%E6%96%B9%E5%BC%8F/): 因为 [vector的内存问题](http://blog.csdn.net/shudou/article/details/17337339)，所以采用了这种精确分配内存的数据结构
