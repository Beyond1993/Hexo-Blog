---
title: 0317 Shortest Distance From All Buildings
date: 2025-02-20 08:46:42
categories: LeetCode
tags:
---

在空地上建**一个**房子，使得这个房子到每个building 曼哈顿距离最短

比较直观的从房子出发，更新每个空地


1. 从一个房子出发，去更新所有空地到这个房子的最短距离，
2. 从每个房子出发，去更新们每个空地到当前房子的距离，这个距离是累加的，这样最后就是这个格子到所有房子的距离和。

```python
from collections import deque

class Solution:
    def bfs(self, grid, distances, row, col):
        dirs = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        rows = len(grid)
        cols = len(grid[0])

        # Use a queue to do a bfs, starting from each cell located at (row, col).
        q = deque([(row, col)])

        # Keep track of visited cells.
        vis = [[False] * cols for _ in range(rows)]
        vis[row][col] = True

        steps = 0

        while q:
            for _ in range(len(q)):
                curr = q.popleft()
                row, col = curr

                # If we reached an empty cell, then add the distance
                # and increment the count of houses reached at this cell.
                if grid[row][col] == 0:
                    distances[row][col][0] += steps
                    distances[row][col][1] += 1

                # Traverse the next cells which is not a blockage.
                for dir in dirs:
                    nextRow = row + dir[0]
                    nextCol = col + dir[1]

                    if 0 <= nextRow < rows and 0 <= nextCol < cols:
                        if not vis[nextRow][nextCol] and grid[nextRow][nextCol] == 0:
                            vis[nextRow][nextCol] = True
                            q.append((nextRow, nextCol))

            # After traversing one level cells, increment the steps by 1.
            steps += 1

    def shortestDistance(self, grid: List[List[int]]) -> int:
        minDistance = float('inf')
        rows = len(grid)
        cols = len(grid[0])
        totalHouses = 0

        # Store { total_dist, houses_count } for each cell.
        distances = [[[0, 0] for _ in range(cols)] for _ in range(rows)]

        # Count houses and start bfs from each house.
        for row in range(rows):
            for col in range(cols):
                if grid[row][col] == 1:
                    totalHouses += 1
                    self.bfs(grid, distances, row, col)

        # Check all empty lands with houses count equal to total houses and find the min ans.
        for row in range(rows):
            for col in range(cols):
                if distances[row][col][1] == totalHouses:
                    minDistance = min(minDistance, distances[row][col][0])

        # If we haven't found a valid cell return -1.
        if minDistance == float('inf'):
            return -1
        return minDistance
```

这个优化的点有两个:
1. 省下一个 visited matrix 矩阵的迭代和空间
2. 第二点比较重要， 避免访问任何无法到达所有房子的空地。

一开始的矩阵：

```txt
[1, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 0]
[0, 0, 0, 2, 0, 0, 1]
```

第一个房子拓展过后:

```txt
[ 1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 0]
[-1, -1, -1,  2, 0, 0, 1]
```

第二个右下角的房子发现相邻的空地还是0， 说明第一次没有走到，这些空地连不到第一个房子，直接就skip 搜索。

```python
from collections import deque
from typing import List

class Solution:
    def shortestDistance(self, grid: List[List[int]]) -> int:
        # Directions: down, up, right, left
        dirs = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        rows, cols = len(grid), len(grid[0])
    
        # Matrix to store total distance sum for each empty cell.
        total = [[0] * cols for _ in range(rows)]
        emptyLandValue = 0
        minDist = float('inf')
        for row in range(rows):
            for col in range(cols):
                # Start a BFS from each house.
                if grid[row][col] == 1:
                    minDist = float('inf')
                    # Use a queue to perform a BFS, starting from the cell at (r, c).
                    q = deque([(row, col)])
                    steps = 0
                    while q:
                        steps += 1
                        for _ in range(len(q)):
                            curr = q.popleft()
                            for dir in dirs:
                                nextRow, nextCol = curr[0] + dir[0], curr[1] + dir[1]
                                # For each cell with the value equal to empty land value
                                # add distance and decrement the cell value by 1.
                                if 0 <= nextRow < rows and 0 <= nextCol < cols and grid[nextRow][nextCol] == emptyLandValue:
                                    grid[nextRow][nextCol] -= 1
                                    total[nextRow][nextCol] += steps
                                    q.append((nextRow, nextCol))
                                    minDist = min(minDist, total[nextRow][nextCol])
                    # Decrement empty land value to be searched in next iteration.
                    emptyLandValue -= 1
        return -1 if minDist == float('inf') else minDist
```

这题的精华在于bfs 的时候，控制 emptyLandValue.

emptyLandValue 是从0, -1, -2, -3 递减的。

所以空地 grid[nextRow][nextCol] 是 -= 1, 也是从 0， -1，-2，递减的
