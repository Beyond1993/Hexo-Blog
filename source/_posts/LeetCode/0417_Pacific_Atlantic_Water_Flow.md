---
title: 0417 Pacific Atlantic Water Flow
date: 2025-05-01 07:11:36
categories: LeetCode
tags:
---

题目描述

左边和上边是太平洋，右边和下边是大西洋.

格子代表高度，问哪些点既能留到太平洋，又能流到大西洋


思路，分开，逆流反推。

先推出哪些点能流到太平洋，再反推哪些点能流到大西洋。

然后取交集

```python
class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        if not heights:
            return []

        m, n = len(heights), len(heights[0])
        pacific = [[False] * n for _ in range(m)]
        atlantic = [[False] * n for _ in range(m)]

        dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

        def dfs(i, j, visited):
            visited[i][j] = True
            for d in dirs:
                next_i = i + d[0]
                next_j = j + d[1]
                if 0 <= next_i < m and 0 <= next_j < n and not visited[next_i][next_j] and heights[i][j] <= heights[next_i][next_j]:
                    dfs(next_i, next_j, visited)

        # first row
        for j in range(n):
            dfs(0, j, pacific)
        ## first col
        for i in range(m):
            dfs(i, 0, pacific)

        # last row
        for j in range(n):
            dfs(m - 1, j, atlantic)

        # last col
        for i in range(m):
            dfs(i, n - 1, atlantic)

        res = []

        for i in range(m):
            for j in range(n):
                if pacific[i][j] and atlantic[i][j]:
                    res.append([i, j])

        return res
```



