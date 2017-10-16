---
title: 5-Longest-Palindromic-Substring
date: 2017-09-95 17:50:13
categories: LeetCode
top: 2
tags:
---

最长回文字串

这题的经典程度，算的上是算法题中的hello word。

## 暴力解法：
O(n^2)

## 暴力解法优化
分为奇偶回文讨论。
```java
public class Solution {
    public String longestPalindrome(String s) {
        int len = s.length();
        int start = 0;
        int maxLen = 0;
        String res = "";
        int curLen1 = 0;
        int curLen2 = 0;
        for (int i = 0; i < len; i++) {
            // aba
            int j = 0;
            curLen1 = 0;
            curLen2 = 0;
            while( i + j < len && i - j >= 0) {
                if (s.charAt(i - j) != s.charAt(i + j)) {
                    break;
                }
                j++;
                curLen1 += 2;
            }
            curLen1 -= 1;
            j = 0;
            while (i + 1 + j < len && i - j >= 0) {
                if (s.charAt(i-j) != s.charAt(i + 1 +j)) {
                    break;
                }
                j++;
                curLen2 += 2;
            }
            
            if (curLen1 > curLen2 && curLen1 > maxLen) {
                start = i - curLen1 / 2 ;
                maxLen = curLen1 ;
            }
            
            if (curLen2 > curLen1 && curLen2 > maxLen) {
                start = i - curLen2 / 2 + 1;
                maxLen = curLen2;
            }
        }
        res = s.substring(start, start + maxLen);
        return res;
    }
}
```

## 递归
```java
public class Solution {
    int max, start, end;
    public String longestPalindrome(String s) {
        max = 0;
        start = 0;
        end = 0;
        if(s == null || s.length() < 2) return s;
        for(int i = 0; i < s.length(); i++)
        {
            findPalindrome(s, i, i);
            if(i + 1 < s.length() && s.charAt(i) == s.charAt(i + 1)) findPalindrome(s, i, i + 1);
        }
        return s.substring(start, end + 1);
    }
    private void findPalindrome(String s, int l, int r)
    {
        while(l - 1 >= 0 && r + 1 < s.length() && s.charAt(l - 1) == s.charAt(r + 1))
        {
            l--;
            r++;
        }
        if(r - l + 1 > max)
        {
            max = r - l + 1;
            start = l;
            end = r;
        }
    }
}
```

## 动态规划
```java
public class Solution {
    public String longestPalindrome(String s) {
        int n = s.length();
        String res = null;
    
        boolean[][] dp = new boolean[n][n];
    
        for (int i = 0; i < n; i++) {
            for (int j = i; j >= 0; j--) {
                dp[j][i] = s.charAt(i) == s.charAt(j) && (i - j < 3 || dp[j + 1][i - 1]);
            
                if (dp[j][i] && (res == null || i - j + 1 > res.length())) {
                    res = s.substring(j, i + 1);
                }
            }
        }
    
        return res;
    }
}
```

