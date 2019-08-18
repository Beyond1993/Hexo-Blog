---
title: 0879 Profitable Schemes
date: 2019-08-18 16:43:55
categories: LeetCode
tags:
---



0 1 背包问题 是指在总重为W 的情况下，能获得最大利润， 这一问是指在达到某个利润的条件下，总共有多少解法。


g is limited, p is not limited


```java
class Solution {    
    // W[i][j] ==> 代表前 i 个 profit, 总人数为 j 的 最大价值。 
    public int profitableSchemes(int G, int P, int[] group, int[] profit) {
        int kMod = 1000000007;
        int K = group.length;
        // dp[k][i][j]:= # of schemes of making profit i with j people by commiting first k crimes.
        int[][][] dp = new int[K+1][P+1][G+1];
        dp[0][0][0] = 1;

        for (int k = 1; k <= K; ++k) {      
          int p = profit[k - 1];
          int g = group[k - 1];
          for (int i = 0; i <= P; ++i)    
            for (int j = 0; j <= G; ++j)
                if (j < g) {
                    dp[k][i][j] = dp[k - 1][i][j] % kMod;
                } else {
                   if (i < p) {
                    dp[k][i][j] = (dp[k - 1][i][j] + dp[k - 1][0][j - g] ) % kMod;
                   } else {
                    dp[k][i][j] = (dp[k - 1][i][j] + dp[k - 1][i - p][j - g] ) % kMod;
                   }
                }
        }
        long sum = 0;
        for (int i = 0; i <= G; i++) {
            sum += dp[K][P][i];
        }
        return (int)(sum % kMod);
    }                                                                                 
}
```
