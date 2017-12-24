---
title: Dynamic-Programming
date: 2017-12-14 20:41:33
categories: Algorithm
tags:
---

http://www.geeksforgeeks.org/top-20-dynamic-programming-interview-questions/


今天下定决心，做一个DP 的总结。

正常情况下，DP 就是 DFS 的优化，所以正常情况下，是先作出DFS的解，再用DP 优化。
DFS 的还有一个好处就是验证有没有循环，比如从左上角走到右下角的min sum,假如是可以四个方向走的话，dfs里是有loop, 这样就没法用DP, 那就只能暴力dfs解，因为DP产生了循环优化的问题，没办法divide into optimal problem。

### 0 1 backpack

问题描述：

有 N 件物品和一个容量为 V 的背包。放入第 i 件物品耗费的费用是 Ci
1，得到的
价值是 Wi。求解将哪些物品装入背包可使价值总和最大。


### Longest Common Subsequence

### Longest Increasing Subsequence

### Edit Distance

### Minimum Partition

### Ways to Cover a Distance

### Longest Path In Matrix

### Subset Sum Problem

### Optimal Strategy for A Game

### Boolean Parentesization Problem

### Shortest Common Supersequence

### Matrix Chain Multiplication

### Partition Problem

### Rod Cutting

### Coin Change Problem

### Word Break Problem

### Maximal Product when cutting Rope

### Dice Throw Problem

### Box Stacking

### Egg Dropping Puzzle

 


小结：之前认为DP 问题很难的原因是，他太跳跃了，一下子就要定义一个状态转移方程，是不是很尴尬。我们要从生长的观点，来看待DP问题，首先，他有可重复子问题，那么我用DFS的递归也可以解决重复子问题啊，问题是DFS太慢了，好我们可以用记忆化搜索。这都是我们正常思维能想到的，但是怎么一下子跳跃到DP呢，这就需要经验的累计。

dp[i][j] 区间 i, j 的性质，有 和 差 bool
