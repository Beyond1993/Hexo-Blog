---
title: 0516 Longest Palindromic Subsequence
date: 2020-03-30 02:49:35
categories: LeetCode
tags:
---

这题的重点在于 Parlindrome 题目dp 的起始位置。

** i = s.length() - 1, j = i + 1 **

```java
public class Solution {
   
    public int longestPalindromeSubseq(String s) {
        int[][] dp = new int[s.length()][s.length()];
        
        for (int i = s.length() - 1; i >= 0; i--) {
            dp[i][i] = 1;
            for (int j = i+1; j < s.length(); j++) {
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = dp[i+1][j-1] + 2;
                } else {
                    dp[i][j] = Math.max(dp[i+1][j], dp[i][j-1]);
                }
            }
        }
        return dp[0][s.length()-1];
    }

}
```
