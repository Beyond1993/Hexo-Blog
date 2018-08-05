---
title: Dynamic Programming
date: 2018-03-05 04:31:11
categories: Dynamic-Programming
tags:
---

入门 + 单序列 LIS
双序列  LCS
矩阵坐标型 
背包型 k napsack
区间及其他类型 matrix multiplication

1. 优化问题或者计数问题
2. 寻找递归式(大问题化小问题)
3. 简单的递归写法时间复杂度过高
   子问题重叠过多
4. 优化
  Bottom up [iterative] small--&lt;big
  Top down with memoization

避免重复计算.

一般DP都能根据递归算出来．

先从Recursion 开始分析．

Top Down VS Bottom Up 用哪个？

1. 哪个好写． memorization
2. Bottom up 可以空间优化. Top Down 不可以空间优化 

面试中遇到新题，怎么判断用哪种？　还是从recursion 的结构看出来.
当我的递归只有一个或者两个方向的时候，可以用Bottom up.

最难的部分就是recursion

```text
 +---->
 |
 |
 V
```

当有四个方向的时候，用Bottom up 可能会非常麻烦. 这时候用Top Down 比较好.

```text
    ^
    |
<---+--->  
    |
    V
```


[LC746 Min Cost Climbing Stairs](http://www.wayne.ink/2018/03/05/LeetCode/0746-Min-Cost-Climbing-Stairs/)

LC 198 House Robber
递归式.

LC 213 House Robber II
有环 第一个偷不偷　转成线性

LC300 Longest increasing subsequence

1.如果 f(i) 代表　前 i 个最长长度，如果仅仅这么定义，当我知道第ｉ个数为K, 时，　并不能确定这个长度是否加１，所以我们需要知道前面最长长度的最后一个元素是多少，如果比那个长度的最后一个元素还大，就可以加１．不行，找到刚好比最后一个元素大的长度，这个长度加１．


f(i) = max(f(k) + 1, if A[i] > A[k]), k  0  ~ i-1 这样就没有空间优化了

LCS

只要考虑前面一个就好了

Game of 5 powers

You are given a string S that consists of character '0' and '1' only. Return the samllest positive integer K such that it is positive to cut S into K pieces, each of them being a power of 5(no leading zeros). if there is no such K, return -1 instead.

e.g. S = "101101101" return 3 (101 = 5)
e.g. S = "1111101" return 1 (1111101 = 125)
e.g. S = "0000" return -1;
e.g. S = "100" return -1;

和回文类似
https://www.youtube.com/watch?v=EysGdX2wSPo&feature=em-share_video_user



经典的DP 问题
0 1 背包
N 取方格数
N Partition
树形动态规划



