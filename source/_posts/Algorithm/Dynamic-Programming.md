---
title: Dynamic Programming
date: 2018-03-05 04:31:11
categories: Algorithm
tags:
---


point 1: ​动态规划的 实质是​分治思想​和​解决冗余 
point 2: ​dp问题的特性 
1.最优子结构性质 
   通俗地讲就是问题的最优解包含其子问题的最优解。 
2.子问题重叠性质 
   递归算法求解问题时，每次产生的子问题并不总是新问题，有些子问题出现多次。 
   子问题的解依赖于更小子问题的解 
3.自底向上的求解方法 
   求解时需要采用自底向上的方法，将每一级子问题的最优值记录下来，直到问题所要求的规模。 
 
point 3:​ 适合求解的问题：max/min/length/largest/smallest/... 
 
point 4: ​动态规划算法适合用来求解最优化问题，步骤： 
(1)        definition: ​分析最优解的性质，刻画最优解的结构特征​。   dp[i] 它的含义  
(2)induction rule: ​递归定义最优值 (即建立递归式)。                      dp[i] = dp[i - 1] .. ..dp[0] 
(3)init & iterative: ​初始化 & 以自底向上的方式计算出最优值。  
(4)              result: ​根据计算最优值时得到的信息，构造出最优解。 
 
point 5：​DP VS Greedy 
相同点： 1. 分治思想 
               2. 最优子结构性质 
不同点：1. Greedy子问题独立，DP子问题重叠 
              2. Greedy从顶向下，DP从底向上 
 
point 6：​DP问题求解图示 
A 代表数据本身， dp代表得到的结果 
←           dealt      →   cur   ←      undealt    →  
  xxxxxxxxxxxxxxxxxx​     ​x​    ​xxxxxxxxxxxxxxxx

_yyyyyyyyyyyyyyyyyy <- 注： 第一个字符"-" 是初始化可能需要增加的补位

- cached data -
           <--i j

```java
/**
          n
         / \ 
      n-1   n-2
    /  \    / \
  n-2 n-3 n-3 n-4

f(n) = f(n-1) + f(n-2)

1 2 3 4 5 6 ... n
1 2 3 5 8 13 ...

definition: dp[i] present number of ways reach to i-th stair
dedution: dp[i] = dp[i-1] + dp[i-2]
init status: dp[0] = 1, dp[1] = 2
result: dp[n-1]
*/

public class ClimbStairs {

}

```


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



