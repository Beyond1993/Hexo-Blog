---
title: 0256 Paint House
date: 2019-07-13 04:55:41
categories: LeetCode
tags:
---

这题带锁

最直观的解法.

```java
class Solution {
    public int minCost(int[][] costs) {
        int n = costs.length;
        int[][] dp = new int[n + 1][3];
        for(int i = 0; i <= n; i++) {
            for(int j = 0; j < 3; j++) {
                dp[i][j] = Integer.MAX_VALUE;
                for(int k = 0; k < 3; k++) {
                    if(i == 0) {
                        dp[i][j] = 0;
                    }
                    if(j == k) {
                        continue;
                    }
                    if(i != 0 && dp[i-1][k] + costs[i-1][j] < dp[i][j]) {
                       dp[i][j] = dp[i-1][k] + costs[i-1][j]; 
                    }
                    
                }
            }
        }
        return Math.min(Math.min(dp[n][0], dp[n][1]), dp[n][2]);
    }
}
```

因为只需要考虑前一个，可以用滚动数组.

```java
class Solution {
    public int minCost(int[][] costs) {
    
        int[][] dp = new int[2][3];
        int index = 0;
        for (int i = 0; i < costs.length; i++) {
            
            dp[(index + 1) % 2][0] =  Math.min(dp[index][1], dp[index][2]) +
                            costs[i][0];
            dp[(index + 1) % 2][1] = Math.min(dp[index][0], dp[index][2]) +
                           costs[i][1];
            dp[(index + 1) % 2][2] = Math.min(dp[index][0], dp[index][1]) +
                           costs[i][2];
            index = (index + 1) % 2; 
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i < 3; i++) {
            res = Math.min(res, dp[index][i]);
        }
        return res;
    }
}
```
