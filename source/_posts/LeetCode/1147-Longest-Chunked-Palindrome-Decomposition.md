---
title: 1147 Longest Chunked Palindrome Decomposition
date: 2019-08-10 22:49:55
categories: LeetCode
tags:
---


```java
class Solution {
    public int longestDecomposition(String text) {
        int n = text.length();
        String left = "";
        String right = "";
        int count = 0;
        for (int i = 0; i < n; i++) {
            left = left + text.charAt(i);
            right = text.charAt(n - i -1) + right; 
            if (left.equals(right)) {
                left = "";
                right = "";
                count++;
            }
        }
        return count++;
    }
}
```


```java
class Solution {
    public int longestDecomposition(String text) {
        
        int leftHash = 0;
        int rightHash = 0;
        int n = text.length();
        int cur = 1;
        int res = 0;
        int l = 0;
        int r = n - 1;
        while(l < r) {
            leftHash = 26 * leftHash + (text.charAt(l) - 'a') ;
            rightHash = rightHash + (text.charAt(r) - 'a') * cur;
            cur *= 26;
            
            if (leftHash == rightHash) {
                leftHash = 0;
                rightHash = 0;
                res += 2;
                cur = 1;
            }
            l++;
            r--; 
        }
        if (l > r && leftHash != rightHash) {
            res += 1;
        }
        if (l == r) {
            res += 1;
        }
        return res;
    }
}
```
