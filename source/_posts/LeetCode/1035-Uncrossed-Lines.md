---
title: 1035 Uncrossed Lines
date: 2019-07-01 02:38:10
categories: LeetCode
tags:
---

```java
class Solution {
    // 最长公共sequence
    /*
          " " 1 4 2
     " "   0  0 0 0
      1    0  1 1 1
      2    0  1 1 2
      4    0  1 2 2 
    */
    
    public int maxUncrossedLines(int[] A, int[] B) {
        
        int m = A.length;
        int n = B.length;
        
        int[][] dp = new int[m+1][n+1];
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n ; j++) {
                if (A[i-1] == B[j-1]) {
                    
                    dp[i][j] = dp[i-1][j-1] + 1;
                } else {
                    dp[i][j] = Math.max(dp[i-1][j], dp[i][j-1]);
                }
                //System.out.println(i + " " + j + " " + dp[i][j]);
            }
        }
        
        return dp[m][n];
    }
}
```
