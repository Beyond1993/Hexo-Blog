---
title: 0343 Integer Break
date: 2019-09-01 01:04:11
categories: LeetCode
tags:
---



剪绳子

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
