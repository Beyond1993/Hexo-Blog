---
title: 0286 Walls And Gates
date: 2025-01-20 08:12:49
categories: LeetCode
tags:
---

题目描述
你被给定一个 m x n 的二维网格房间 rooms，其中：

rooms[i][j] == -1 表示该位置是一个墙或障碍物。
rooms[i][j] == 0 表示该位置是一个门。
rooms[i][j] == INF 表示该位置是一个空的房间。INF 被定义为 2^31 - 1（即 2147483647），你可以认为它是一个无穷大的值。

输出:你需要用「到最近门的距离」来填充每个空房间。如果无法到达门，则保持为 INF。

规则
你只能在上下左右四个方向上移动。
你需要直接修改输入的网格 rooms。

示例
输入：
text
Copy
Edit
rooms = [
  [INF, -1,  0,  INF],
  [INF, INF, INF, -1],
  [INF, -1,  INF, -1],
  [  0, -1,  INF, INF]
]
输出：
text
Copy
Edit
rooms = [
  [  3, -1,   0,   1],
  [  2,   2,   1,  -1],
  [  1,  -1,   2,  -1],
  [  0,  -1,   3,   4]
]
解释
从每个空房间计算到最近门的距离。
用最短路径的距离更新房间中的值。
例如，输入的 (0, 0) 是 INF，从它到最近的门 (0, 2) 的距离是 3，因此输出的 (0, 0) 为 3。

提示
你可以假设每个房间至少有一个门。

```python
from collections import deque
from typing import List

class Solution:
    def __init__(self):
        self.gate = 0
        self.directions = [(0, -1), (-1, 0), (0, 1), (1, 0)]  # left, up, right, down

    def wallsAndGates(self, rooms: List[List[int]]) -> None:
        if not rooms:
            return

        rows_count = len(rooms)
        cols_count = len(rooms[0])

        # 1. Find all gates
        q = deque()
        for r in range(rows_count):
            for c in range(cols_count):
                if rooms[r][c] == self.gate:
                    q.append((r, c))

        # 2. Find shortest distance to gate using BFS
        while q:
            r, c = q.popleft()
            candidate_distance = rooms[r][c] + 1

            for d_r, d_c in self.directions:
                adj_r, adj_c = r + d_r, c + d_c
                if adj_r < 0 or adj_r >= rows_count or adj_c < 0 or adj_c >= cols_count:
                    continue
                
                # Update distance if the new candidate distance is smaller
                if candidate_distance < rooms[adj_r][adj_c]:  # Walls (-1) are ignored as candidate_distance > -1
                    rooms[adj_r][adj_c] = candidate_distance
                    ## 放回queue 是为了再更新这个节点的neighbors 距离
                    q.append((adj_r, adj_c))
```

