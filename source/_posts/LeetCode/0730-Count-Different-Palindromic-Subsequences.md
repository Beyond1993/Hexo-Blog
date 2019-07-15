---
title: 0730 Count Different Palindromic Subsequences
date: 2019-07-14 23:32:23
categories: LeetCode
tags:
---

case1: dp[i][i] = 1

case2: s[i] == s[j] 

case2.1 : don't find s[i] inside i + 1 ~ j -1, dp[i+1][j-1] * 2 + 2 

case2.2 : find one: dp[i+1][j-1] * 2 + 1

case2.3 : find twe or more. remove the overlap bewteen first left char and first right char : dp[i+1][j-1] * 2 -  dp[l+1][r-1]

case3: s[i] != s[j] : dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1]


must start try by length


```java
class Solution {
    private static final int kMod = 1000000007;
    public int countPalindromicSubsequences(String S) {
        if (S == null || S.isEmpty()) return 0;
        int n = S.length();
        char[] s = S.toCharArray();
        int[][] dp = new int[n][n];
        
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        
        for (int distance = 1; distance < n; distance ++) {
            for (int i = 0; i + distance < n; i++) {
                int j = i + distance;
                
                if (s[i] == s[j]) {
                    int l = i + 1;
                    int r = j - 1;
                    
                    while(s[l] != s[i]) l++;
                    while(s[r] != s[i]) r--;
                    
                    if (l == j) {
                        dp[i][j] = dp[i+1][j-1] * 2 + 2;
                    } else
                    if (l == r) {
                        dp[i][j] = dp[i+1][j-1] * 2 + 1;
                    } else {
                        dp[i][j] = dp[i+1][j-1] * 2 - dp[l+1][r-1];
                    } 
                } else {
                    dp[i][j] = dp[i][j - 1] + dp[i+1][j] - dp[i+1][j-1]; 
                }
                dp[i][j] = dp[i][j] < 0 ? dp[i][j] + kMod : dp[i][j] % kMod;
                //System.out.println(i + " " + j + " " + dp[i][j]);
            }
        }
        
        return dp[0][n-1];
    }
    
}
```
