---
title: Interview-Follow-UP
date: 2017-10-03 20:55:55
categories: 面试
tags:
---

面试题中的Follow up,是筛选面试者的一个标准。很有必要总结常见的follow up


1. O(n^2) --> O(nlogn) --> O(n) --> O(1), hashmap, binary search, dp
2. input is a stream, input can not load into memory. 记录position，sliding window + deque + lru 
3. 跟前缀有关的 可以从dfs优化为trie，可以挑最小的集合组 来建trie
4. 输入的字典无限大， word search II.
5. 输出最优解或一个解 --> 所有可能解，track 信息，dfs + memorization 
6. 图算法 --> 这个图无限大, 图无限大可以用key value pairs去表示一个图。然后存hdfs上mapreduce。然后再考虑spark和graphX包
7. 一维 --> 多维
8. 去重.

这是我们今天总结的 常见 follow up, 欢迎大神补充

口诀：
有套路，如果问最短，最少，BFS
如果问连通性，静态就是 DFS,BFS，动态就 UF
如果问依赖性就 topo sort
DAG 的问题就 dfs+memo
矩阵和 Array 通常都是 DP
问数量的通常都是 DP
问是否可以，也很有可能 DP
求所有解的，基本 backtracking
排序总是可以想一想的
再不行就数据结构头脑风暴
对了，别忘了还有分治这个好东西
其实从数据规模或者说要求的复杂度上也能看出解法
最小堆好好利用，往往可以把问题复杂度从 n^2 降为 n
如果遇到二维 dp 不会，先考虑一维情况如何解
