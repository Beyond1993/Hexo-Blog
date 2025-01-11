---
title: 1930 Unique Length 3 Palindromic Subsequences
date: 2025-01-11 08:12:04
categories: LeetCode
tags:
---


```python
class Solution:
    def countPalindromicSubsequence(self, s: str) -> int:
        unique_chars = set(s)
        res = 0
        for c in unique_chars:
            left, right = s.index(c), s.rindex(c)
            between = set()
            for i in range(left, right + 1):
                between.add(s[i])
            res += len(between)
        return res
```
