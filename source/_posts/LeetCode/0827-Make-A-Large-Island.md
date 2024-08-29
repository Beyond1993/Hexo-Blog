---
layout: 827-making-a-large-island
title: 0827-Make-A-Large-Island
date: 2024-08-29 08:38:31
tags:
---


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
