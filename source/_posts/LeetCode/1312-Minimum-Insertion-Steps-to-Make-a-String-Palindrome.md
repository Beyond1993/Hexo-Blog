---
title: 1312. Minimum Insertion Steps to Make a String Palindrome
date: 2020-03-30 03:19:25
categories: LeetCode
tags:
---

求 longest parlindrome subsequence

```java
class Solution {
    public int minInsertions(String s) {
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
        return s.length() - dp[0][s.length()-1];
    }
}
```

直接 dp:

```java
class Solution {
    public int minInsertions(String s) {
        int[][] dp = new int[s.length()][s.length()];
        char[] a = s.toCharArray();
        for (int i = 0; i < s.length(); i++) {
            for (int j = i - 1; j >= 0; j--) {
                if (a[i] == a[j]) {
                    dp[j][i] = dp[j+1][i-1];
                } else {
                    dp[j][i] = Math.min(dp[j+1][i], dp[j][i-1]) + 1;
                }
            }
        }
        return dp[0][s.length()-1];
    }
}
```
