---
title: 0329 Longest Increasing Path In A Matrix
date: 2025-02-09 07:38:35
categories: LeetCode
tags:
---

memoe search
时间复杂度：O(m * n)
空间复杂度：O(m * n)

这个dfs 非常巧妙，相当于先把边界的一圈先设置成 1, 然后不断更新 每个节点

```python
class Solution:
    dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]  # Directions: right, down, left, up

    def longestIncreasingPath(self, matrix):
        if not matrix or not matrix[0]:
            return 0
        
        m, n = len(matrix), len(matrix[0])
        cache = [[0] * n for _ in range(m)]  # Cache to store results of subproblems
        
        max_len = 1
        for i in range(m):
            for j in range(n):
                max_len = max(max_len, self.dfs(matrix, i, j, m, n, cache))
        
        return max_len

    def dfs(self, matrix, i, j, m, n, cache):
        if cache[i][j] != 0:
            return cache[i][j]
        
        max_len = 1
        for dir in self.dirs:
            x, y = i + dir[0], j + dir[1]
            if 0 <= x < m and 0 <= y < n and matrix[x][y] > matrix[i][j]:
                max_len = max(max_len, 1 + self.dfs(matrix, x, y, m, n, cache))
        
        cache[i][j] = max_len
        return max_len
```


time complexity : O(m∗nlog(m∗n))

```python
class Solution:
    dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]  # 方向：右，下，左，上

    def longestIncreasingPath(self, matrix):
        if not matrix or not matrix[0]:
            return 0
        
        m, n = len(matrix), len(matrix[0])
        dp = [[1] * n for _ in range(m)]  # 初始化 dp 数组，默认每个单元格的路径长度为 1

        # 使用 topological order (从小到大的顺序遍历矩阵)
        # 通过存储矩阵的所有单元格并按值从小到大排序，逐步计算递增路径
        cells = [(matrix[i][j], i, j) for i in range(m) for j in range(n)]
        
	```
	cells = [
	    (9, 0, 0), (9, 0, 1), (4, 0, 2),
	    (6, 1, 0), (6, 1, 1), (8, 1, 2),
	    (2, 2, 0), (1, 2, 1), (1, 2, 2)
	]
	```
	# 因为这个cells 是个矩阵，所以这个sort 本身就是 m * n * Log(m * n), 有点像 N log N 
        cells.sort()  # 按照值从小到大排序

        # 计算每个单元格的 dp 值
        for value, i, j in cells:
            for dir in self.dirs:
                x, y = i + dir[0], j + dir[1]
                if 0 <= x < m and 0 <= y < n and matrix[x][y] > matrix[i][j]:
                    dp[x][y] = max(dp[x][y], dp[i][j] + 1)

        # 返回 dp 数组中的最大值
        return max(max(row) for row in dp)
```
