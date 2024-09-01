---
title: LeetCode-BFS
date: 2024-09-01 07:22:30
categories: LeetCode-Index
tags:
---

在 BFS (Breadth-First Search) 算法中，标记节点为已访问 的时机是关键，它影响算法的正确性和效率。通常，标记节点为已访问的最佳实践是在节点被入队之前进行。这可以确保我们不会将重复的节点添加到队列中，从而避免不必要的处理和提高算法效率。

为什么在入队之前标记为已访问
避免重复入队：
如果我们在节点被入队之前标记为已访问，可以防止节点多次被加入到队列。每个节点被处理一次，可以减少重复计算并提高效率。
确保节点处理一次：
通过在入队之前标记节点为已访问，可以确保每个节点在 BFS 遍历过程中只被处理一次，这有助于维护 BFS 的逐层遍历特性。
减少额外检查：
如果我们在节点出队后标记为已访问，可能会遇到重复处理的情况，因为同一个节点可能会被多次加入到队列中。这样会增加额外的检查和处理，从而影响性能。
实际实现
下面是一个标准的 BFS 实现示例，说明了如何在入队之前标记节点为已访问：
Leetcode 1091
```python
from collections import deque
from typing import List
class Solution:
    def shortestPathBinaryMatrix(self, grid: List[List[int]]) -> int:
        n = len(grid)
        
        # Check if the start or end cell is blocked
        if grid[0][0] == 1 or grid[n-1][n-1] == 1:
            return -1
        
        # Directions: 8 possible moves
        directions = [(-1, 0), (0, -1), (1, 0), (0, 1), (-1, -1), (1, -1), (-1, 1), (1, 1)]
        
        # Initialize the BFS queue
        q = deque([(0, 0, 1)])  # (x, y, steps)
        grid[0][0] = 1  # Mark the start cell as visited
        
        while q:
            x, y, steps = q.popleft()
            
            # Check if the destination is reached
            if x == n - 1 and y == n - 1:
                return steps
            
            # Explore all 8 possible directions
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                
                # Check boundaries and if the cell is open and not yet visited
                if 0 <= nx < n and 0 <= ny < n and grid[nx][ny] == 0:
                    grid[nx][ny] = 1  # Mark as visited
                    q.append((nx, ny, steps + 1))
        
        return -1
```
总结
在 BFS 算法中，应在节点入队之前标记为已访问。这样做可以避免节点重复入队，保证每个节点只被处理一次，从而提高算法效率并保持正确性。


        1
      / | \
     2--3  4
     |
     5 

比如这种情况，如果是出队之后在标记成visited, 

2 出队的时候会把3 也重复加入到队列里

[1], 1 出队 [2,3,4], 2 出队 [3,4,3,5]



