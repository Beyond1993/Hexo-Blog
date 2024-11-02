---
title: page
date: 2024-11-02 08:07:34
categories: LeetCode
tags:
---


```python
class Solution:
    def simplifyPath(self, path: str) -> str:
        arr = path.split('/')
        stack = []
        for c in arr:
            if c == '' or c == '.':
                continue
            if c == "..":
                if len(stack) > 0:
                    stack.pop()
                continue
            stack.append(c)
        return "/" + "/".join(stack)
```
