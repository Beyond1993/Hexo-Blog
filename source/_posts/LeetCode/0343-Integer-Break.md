---
title: 0343 Integer Break
date: 2019-09-01 01:04:11
categories: LeetCode
tags:
---


Given a positive integer n, break it into the sum of at least two positive integers and maximize the product of those integers. Return the maximum product you can get.

Example 1:

Input: 2
Output: 1
Explanation: 2 = 1 + 1, 1 × 1 = 1.
Example 2:

Input: 10
Output: 36
Explanation: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36.

剪绳子

给一段长度为 n 的绳子, 至少剪一次，每次剪完算乘积，求最大乘积

//递归写法
```java
class Solution {
    Map<Integer,Integer> map = new HashMap<>();
    
    public int integerBreak(int n) {
        int max = Integer.MIN_VALUE;
        for (int i = 1; i <= n / 2; i++)
            max = Math.max(max, dfs(i) * dfs(n-i));
        return max;
    }

    private int dfs(int n) {
        //System.out.println(n);
        if (n == 0)
            return 1;
        if (map.containsKey(n))
            return map.get(n);
       
        int max = n;
        for (int i = 1; i <= n / 2; i++)
            max = Math.max(max, dfs(i) * dfs(n-i));
        map.put(n, max);
        return max;
    }
}
```


```java
class Solution {
    Map<Integer,Integer> map = new HashMap<>();
    
    public int integerBreak(int n) {
        int max = Integer.MIN_VALUE;
        for (int i = 1; i < n ; i++)
            max = Math.max(max, dfs(i) * dfs(n-i));
        return max;
    }

    private int dfs(int n) {
        if (n == 0)
            return 1;
        if (map.containsKey(n))
            return map.get(n);
       
        int max = n;
        for (int i = 1; i < n ; i++)
            max = Math.max(max, dfs(i) * dfs(n-i));
        map.put(n, max);
        return max;
    }
}
```


```java
class Solution {
    public int integerBreak(int n) {
        if (n == 1) return 1;
        int[] dp = new int[n+1];
        dp[1] = 1;
        // dp[0] 代表不剪，就一定要剪
        for (int i = 2; i <=n; i++) {
            // 从逻辑上看 j < i, 因为 j == i 时，代表 dp[i-j] = dp[0] 不剪
            // for (int j = 1; j <= i; j++ )
            for (int j = 1; j < i; j++ ) {
                //Math.max(j, dp[j]) 决定了剪还是不剪, j 或者 i - j 代表不剪
                dp[i] = Math.max(dp[i], Math.max(j, dp[j]) * Math.max(i - j, dp[i - j]));
            }
        }
        return dp[n];
    }
}
```
