---
title: 0392 Is Subsequence
date: 2025-01-04 08:23:24
categories: LeetCode
tags:
---


```python
class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        if len(s) > len(t) : return False
        p1, p2 = 0, 0 

        while p1 < len(s) and p2 < len(t):
            
            if t[p2] == s[p1]:
                p1 += 1
                p2 += 1
            else:
                p2 += 1
        
        return True if p1 == len(s) else False  
```
