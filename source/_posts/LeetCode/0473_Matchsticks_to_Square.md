---
title: 0473_Matchsticks_to_Square
date: 2024-10-18 07:46:23
categories: LeetCode
tags:
---


```python
class Solution:
    def makesquare(self, matchsticks: List[int]) -> bool:
        total = sum(matchsticks)
        maxEdge = max(matchsticks)
        edgeLen = total // 4
        
        # Check if total is divisible by 4 and no single matchstick is longer than edge length
        if total % 4 != 0 or maxEdge > edgeLen:
            return False

        # Sort matchsticks in descending order
        matchsticks.sort(reverse=True)

        def dfs(edges, index):
            # If we have used all matchsticks, check if all edges are equal to target length
            if index == len(matchsticks):
                return all(edge == edgeLen for edge in edges)
            
            for j in range(4):  # Try to place the current matchstick in each edge
                if edges[j] + matchsticks[index] <= edgeLen:
                    edges[j] += matchsticks[index]  # Place matchstick
                    if dfs(edges, index + 1):  # Move to the next matchstick
                        return True
                    edges[j] -= matchsticks[index]  # Backtrack

                # If this edge is 0, there's no point in trying to place the matchstick in another empty edge
                if edges[j] == 0:
                    break

            return False
        
        return dfs([0] * 4, 0)
```
