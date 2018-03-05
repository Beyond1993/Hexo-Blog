---
title: 0746 Min Cost Climbing Stairs
date: 2018-03-05 04:52:05
categories: LeetCode
tags:
---

On a staircase, the i-th step has some non-negative cost cost[i] assigned (0 indexed).

Once you pay the cost, you can either climb one or two steps. You need to find minimum cost to reach the top of the floor, and you can either start from the step with index 0, or the step with index 1.

Example 1:
Input: cost = [10, 15, 20]
Output: 15
Explanation: Cheapest is start on cost[1], pay that cost and go to the top.
Example 2:
Input: cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
Output: 6
Explanation: Cheapest is start on cost[0], and only step on 1s, skipping cost[3].

Note:
cost will have a length in the range [2, 1000].
Every cost[i] will be an integer in the range [0, 999].

递归式:
f(i) : min cost to reach cost[i]

f(i) = min(f(i-1), f(i-2)) + cost[i]
f(0) = cost[0]
f(1) = cost[1]

```java
public int minCostClimbingStairs(int[] cost) {
  int n = cost.length;
  return Math.min(rec(cost, n -1), rec(cost, n - 2));
}

private int rec(int[] cost, int i) {
  if ( i == 0 || i == 1) return cost[i];
  return Math.min(rec(cost,i - 1), rec(cost, i - 2)) + cost[i];
}
```
时间复杂度 : O(2^n) 

斐波拉切数列的时间复杂度  1.618^n

google一下特征根法求解数列通项公式， 斐波那契数列是属于常系数齐次线性递推数列，有求解这种递推表达式的通法，其实和解微分方程的思路有点像
```text
               T(n)
            /       \
      T(n-1)         T(n-2)
       /   \          /    \
     T(n-2) T(n-3) T(n-3) T(n-4)
    ...........................

像 T(n-2) T(n-3) 都是重复子问题
```
优化之 Top Down + Memoization
```java
public int minCostClimbingStairs(int[] cost) {
  int n = cost.length;
  int[] dp = new int[n];
  Arrays.fill(dp, -1);
  return Math.min(rec(cost, n - 1, dp), rec(cost, n - 2, dp));
}

private int rec(int[] cost, int i, int[] dp) {
  if (i == 0 || i == 1) return cost[i];
  if (dp[i] != -1) return dp[i];
  dp[i] = Math.min(rec(cost, i - 1, dp), rec(cost, i - 2, dp)) + cost[i];
  return dp[i];
}
```

这样时间复杂度就降到了 O(n) , 因为dp 的长度是n, 每个dp 只 遍历了一次 


优化之 Bottom Up

```java
public int minCostCLimbingStairs(int[] cost) {
  int n = cost.length;
  int[] dp = new int[n];
  dp[0] = cost[0];
  dp[1] = cost[1];
  for (int i = 2; i < n; i++) {
    dp[i] = Math.min(dp[i-1], dp[i-2]) + cost[i];
  }
  return Math.min(dp[n-2], dp[n-1]);
}
```

先计算最小的instance, bottom up 

时间复杂度 空间复杂度 O(n)

空间优化: O(n) --> O(1)

因为只要看前面两个状态

这种空间优化只能用buttom - up

```java 
public int minCostClimbingStairs(int[] cost) {
  int n = cost.length;
  int a = cost[0];
  int b = cost[1];
  for (int i = 2; i < n; i++) {
    int c = Math.min(a,b) + cost[i];
    a = b;
    b = c;
  }
  return Math.min(a,b);
}
```

这种写法比较土

如果是 f(i) = min(f(i-1) + f(i-2) + f(i-3) + f(i-4)) + cost[i]

用取模

```java
public int minCostClimbingStairs(int[] cost) {
  int n = cost.length;
  int[] dp = {cost[0], cost[1]};
  for (int i = 2; i < n; i++) {
    dp[i % 2] = Math.min(dp[(i-1) % 2], dp[(i-2) % 2]) + cost[i];
  }
  return Math.min(dp[0], dp[1]);
}
```
