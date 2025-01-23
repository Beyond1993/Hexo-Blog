---
title: 0296-Best-Meeting-Room
date: 2017-10-09 19:42:24
categories: LeetCode
tags:
---

1，代表朋友家，0 代表餐厅， 不同的朋友 聚餐，找到离大家位置最近的饭店

利用中位数定理，计算曼哈顿距离，

选择中位数的原因：

当我们要求多个点到一个目标点的最小曼哈顿距离时，选择 中位数 可以使得所有点到目标点的总曼哈顿距离最小。
在这个问题中，我们分别求出行和列的中位数，从而确定最优的位置（最小曼哈顿距离的位置）。
举个例子：
假设 grid 如下：

```python
grid = [
    [0, 1, 0],
    [1, 0, 0],
    [0, 0, 1]
]
```
collectRows(grid)：找到所有包含 1 的行，结果是 [0, 1, 2]。
collectCols(grid)：找到所有包含 1 的列，结果是 [1, 0, 2]。
然后：

对行 [0, 1, 2]，选择中位数 1 作为目标行。
对列 [1, 0, 2]，选择中位数 1 作为目标列。
这就意味着，最佳的目标位置是 (1, 1)，即行和列的中位数。

总结：
通过选择 中位数 作为目标位置，我们能够最小化 曼哈顿距离的总和，这是因为中位数代表了数据的平衡点，它能有效地减少所有点到目标点的总距离。

```python
class Solution:
    def minTotalDistance(self, grid: List[List[int]]) -> int:
        # Collect rows and columns containing 1
        rows = self.collectRows(grid)
        cols = self.collectCols(grid)
        
        # Calculate the minimum Manhattan distance
        return self.minDistance1D(rows) + self.minDistance1D(cols)

    def minDistance1D(self, points):
        # Use two pointers to calculate the minimum distance
        distance = 0
        i = 0
        j = len(points) - 1
        while i < j:
            distance += points[j] - points[i]
            i += 1
            j -= 1
        return distance

    def collectRows(self, grid):
        rows = []
        for row in range(len(grid)):
            for col in range(len(grid[0])):
                if grid[row][col] == 1:
                    rows.append(row)
        return rows

    def collectCols(self, grid):
        cols = []
        for col in range(len(grid[0])):
            for row in range(len(grid)):
                if grid[row][col] == 1:
                    cols.append(col)
        return cols
```
