---
title: Dynamic-Programming
date: 2017-12-14 20:41:33
categories: LeetCode
tags:
---

http://www.geeksforgeeks.org/top-20-dynamic-programming-interview-questions/


今天下定决心，做一个DP 的总结。

正常情况下，DP 就是 DFS 的优化，所以正常情况下，是先作出DFS的解，再用DP 优化。
DFS 的还有一个好处就是验证有没有循环，比如从左上角走到右下角的min sum,假如是可以四个方向走的话，dfs里是有loop, 这样就没法用DP, 那就只能暴力dfs解，因为DP产生了循环优化的问题，没办法divide into optimal problem。

0 1 backpack

问题描述：

有 N 件物品和一个容量为 V 的背包。放入第 i 件物品耗费的费用是 Ci
1，得到的
价值是 Wi。求解将哪些物品装入背包可使价值总和最大。




