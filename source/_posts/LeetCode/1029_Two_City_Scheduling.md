---
title: 1029 Two City Scheduling
date: 2024-12-21 10:55:20
categories: LeetCode
tags:
---

brute force
```python
class Solution:
    def twoCitySchedCost(self, costs: List[List[int]]) -> int:
        n = len(costs) // 2
        res = float('inf')
        def dfs(i, count1, count2, sum_):
            nonlocal res
            if i == 2 * n:
                if count1 == n and count2 == n:
                    res = min(res, sum_)
                    return
            if count1 < n:
                dfs(i + 1, count1 +1, count2, sum_ + costs[i][0])
            if count2 < n:
                dfs(i + 1, count1, count2 + 1, sum_ + costs[i][1])
        
        dfs(0, 0, 0, 0)
        return res
```

Greedy
```python
from typing import List

class Solution:
    def twoCitySchedCost(self, costs: List[List[int]]) -> int:
        # Sort by the difference between city A and city B costs
        costs.sort(key=lambda x: x[0] - x[1])
        
        n = len(costs) // 2
        total_cost = 0
        
        # Assign the first n people to city A and the rest to city B
        for i in range(len(costs)):
            if i < n:
                total_cost += costs[i][0]  # City A
            else:
                total_cost += costs[i][1]  # City B
        
        return total_cost
```
