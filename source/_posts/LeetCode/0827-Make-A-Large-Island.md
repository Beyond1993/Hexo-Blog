---
layout: 827-making-a-large-island
title: 0827-Make-A-Large-Island
date: 2024-08-29 08:38:31
tags:
---

整体思路是 扫两遍

第一遍扫没有填海的

第二遍扫 填过一次海的。

color 主要是标记 不同岛屿

Example:
Consider the following grid (a 5x5 grid for simplicity):

grid = [    [1, 1, 0, 0, 0],
    [1, 1, 0, 0, 1],
    [0, 0, 0, 1, 1],
    [0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0]
]
After the DFS traversal, the grid might look like this (with the colors representing different islands):

grid = [    [2, 2, 0, 0, 0],
    [2, 2, 0, 0, 3],
    [0, 0, 0, 3, 3],
    [0, 0, 3, 3, 0],
    [0, 0, 0, 0, 0]
]

这样在遍历自己周边岛屿的时候，不会有重复
colors = {self.getColor(j, i - 1), self.getColor(j, i + 1),
self.getColor(j - 1, i), self.getColor(j + 1, i)}

colors 的长度从0 到 4 不等

由于要更新 grid[x][y] = color, 所以color 必须选一个 非 0， 1 的值	


```python3
class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        ## color 必须初始化为 >= 1, 因为后面 
        ## self.grid[y][x] != 1 来判读是否访问过
        ## self.grid[y][x] = self.color
        self.color = 2
        self.grid = grid
        self.m = len(grid)
        self.n = len(grid[0])
        self.areas = {}  # color -> area
        ans = 0
        
        for i in range(self.m):
            for j in range(self.n):
                if grid[i][j] == 1:
                    self.color += 1
                    self.areas[self.color] = self.getArea(j, i)
                    ans = max(ans, self.areas[self.color])
        
        for i in range(self.m):
            for j in range(self.n):
                if grid[i][j] == 0:
                    area = 1
                    # Collect unique neighboring colors
                    colors = {self.getColor(j, i - 1), self.getColor(j, i + 1),
                              self.getColor(j - 1, i), self.getColor(j + 1, i)}
                    for color in colors:
                        area += self.areas.get(color, 0)
                    ans = max(ans, area)
        
        return ans
    
    def getColor(self, x, y):
        if x < 0 or x >= self.n or y < 0 or y >= self.m:
            return 0
        return self.grid[y][x]
    
    def getArea(self, x, y):
        if x < 0 or x >= self.n or y < 0 or y >= self.m or self.grid[y][x] != 1:
            return 0
        self.grid[y][x] = self.color
        return 1 + self.getArea(x - 1, y) + self.getArea(x + 1, y) \
                   + self.getArea(x, y - 1) + self.getArea(x, y + 1)
```
