---
title: 1306 Jump Game III
date: 2025-01-14 11:09:04
categories: LeetCode
tags:
---

```python
class Solution:
    def canReach(self, arr: List[int], start: int) -> bool:
        visited = set()
        def dfs(i):
            if i in visited:
                return False
            else:
                visited.add(i)

            if i < 0 or i >= len(arr): return False
            if arr[i] == 0:
                return True
                
            return dfs(i - arr[i]) or dfs(i + arr[i])
        return dfs(start)
```
