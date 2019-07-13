---
title: 0256 Paint House
date: 2019-07-13 04:55:41
categories: LeetCode
tags:
---



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
