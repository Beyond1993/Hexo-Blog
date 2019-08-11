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
