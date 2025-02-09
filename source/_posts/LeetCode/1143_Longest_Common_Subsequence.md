---
title: 1143 Longest Common Subsequence
date: 2025-02-09 07:06:10
categories: LeetCode
tags:
---

正常画一个矩阵，先初始化 [0, 0], 再初始化行，列. 再初始化整个矩阵

```python
class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        m = len(text1)
        n = len(text2)

        dp = []

        for i in range(m):
            dp.append([0]*n)

        dp[0][0] = 1 if text1[0] == text2[0] else 0
        
        for j in range(1,n):
            dp[0][j] = 1 if text1[0] == text2[j] else dp[0][j-1]

        for i in range(1,m):
            dp[i][0] = 1 if text1[i] == text2[0] else dp[i-1][0]

        for i in range(1,m):
            for j in range(1, n):
            
                if text1[i] == text2[j]:
                    dp[i][j] = dp[i-1][j-1] + 1
                else:
                    dp[i][j] = max(dp[i-1][j-1], dp[i-1][j], dp[i][j-1])

       
        
        return dp[m-1][n-1]
```


        

