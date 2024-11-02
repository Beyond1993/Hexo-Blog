---
title: page
date: 2024-11-02 06:19:05
categories: LeetCode
tags:
---

```python
from typing import List

class Solution:
    def groupStrings(self, strings: List[str]) -> List[List[str]]:
        
        def calDiff(s):
            if len(s) == 1:
                return "1"
            key = []
            for i in range(1, len(s)):
                # Calculate the difference and normalize it to be within 0-25
                diff = (ord(s[i]) - ord(s[i - 1])) % 26
                key.append(diff)
            return tuple(key)  # Use a tuple to make it hashable

        resMap = {}
        for string in strings:
            key = calDiff(string)
            if key not in resMap:
                resMap[key] = []
            resMap[key].append(string)

        return list(resMap.values())  # Convert to list before returning
```

这里不能写成  resMap[key] = resMap.get(key. []).append(string)

因为 append 返回的是None 
