---
title: 1000 Minimum Cost to Merge Stones
date: 2019-08-30 03:13:53
categories: LeetCode
tags:
---


先解决最小子问题: 长度为2 的区间里的石头分成一堆的 cost, 

每个子问题又分解成两步

1. 长度为 len 的区间，分成 K 份的最小cost
2. 将这 K 份 合成一份的cost

```java
class Solution {
    public int mergeStones(int[] stones, int K) {
        int n = stones.length;
        if ((n - 1) % (K - 1) != 0) return -1;
        int[] sums = new int[n + 1];
        for (int i = 0; i < stones.length; ++i) 
          sums[i + 1] = sums[i] + stones[i];

        int kInf = Integer.MAX_VALUE;
        int[][][] dp = new int[n][n][K+1];
        
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                for (int k = 0; k <= K; k++) {
                    dp[i][j][k]= kInf;
                }
        
        for (int i = 0; i < n; ++i) dp[i][i][1] = 0;

        for (int l = 2; l <= n; ++l) 
          for (int i = 0; i <= n - l; ++i) { 
            int j = i + l - 1;
            for(int k = 2; k<= K; ++k) {
              for (int m = i; m < j ; m += K - 1) 
                  dp[i][j][k] = Math.min(dp[i][j][k], dp[i][m][1] + dp[m + 1][j][k-1]);
              if(dp[i][j][K] < kInf)
                dp[i][j][1] = dp[i][j][K] + sums[j+1] - sums[i];
          }
        }
        return dp[0][n - 1][1];
    }
}
``` 
