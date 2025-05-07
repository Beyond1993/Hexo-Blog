---
title: Uber-Robots
date: 2025-05-07 13:47:17
categories: Interview
tags:
---

https://leetcode.com/discuss/post/4718477/uber-phone-screen-amsterdam-by-anonymous-kxcs/

Given two inputs,

First input is the location map, a 2D array

```txt
| O | E | E | E | X |
| E | O | X | X | X |
| E | E | E | E | E |
| X | E | O | E | E |
| X | E | X | E | X |
```

O = Robot, E = Empty, X = blocker

```txt
{
 {'O','E','E','E','X'},
 {'E','O','X','X','X'},
 {'E','E','E','E','E'},
 {'X','E','O','E','E'},
 {'X','E','X','E','X'}
}
```

Second input is the query. It’s a 1D array consisting of distance to the closest blocker in the order from left, top, bottom and right
[2, 2, 4, 1] -> This means distance of 2 to the left blocker, 2 to the top blocker, 4 to the bottom blocker and 1 to the right blocker

The location map boundary is also considered blocker, meaning if the robot hits the boundary it also means it’s hitting the blocker.

Task: Write a function that takes these two inputs and returns the index of the robots (if any) that matches the query that we’re looking for.
Answer: [[1, 1]]

```python
from collections import deque

def find_robots_with_matching_query(map, query):
    rows = len(map)
    cols = len(map[0]) if rows > 0 else 0

    def distance_in_direction(r, c, dr, dc):
        dist = 0
        r += dr
        c += dc
        while 0 <= r < rows and 0 <= c < cols and map[r][c] == 'E':
            dist += 1
            r += dr
            c += dc
        return dist  # 遇到 X 或边界，停止

    # 找出所有的机器人
    robots = [(i, j) for i in range(rows) for j in range(cols) if map[i][j] == 'O']
    matching_robots = []

    for r, c in robots:
        distances = [
            distance_in_direction(r, c, 0, -1),  # 左
            distance_in_direction(r, c, -1, 0),  # 上
            distance_in_direction(r, c, 1, 0),   # 下
            distance_in_direction(r, c, 0, 1)    # 右
        ]
        if distances == query:
            matching_robots.append([r, c])

    return matching_robots
```

预处理 优化
```python
def find_robots_with_matching_query(grid, query):
    rows, cols = len(grid), len(grid[0])
    memo = {}

    # 定义方向
    dirs = {
        'left': (0, -1),
        'top': (-1, 0),
        'bottom': (1, 0),
        'right': (0, 1)
    }
    dir_names = ['left', 'top', 'bottom', 'right']

    def dfs(r, c, dr, dc):
        key = (r, c, dr, dc)
        if key in memo:
            return memo[key]

        next_r, next_c = r + dr, c + dc
        if not (0 <= next_r < rows and 0 <= next_c < cols) or grid[next_r][next_c] == 'X':
            memo[key] = 0
            return 0

        # 继续往该方向走
        memo[key] = 1 + dfs(next_r, next_c, dr, dc)
        return memo[key]

    # 遍历所有机器人
    result = []
    for r in range(rows):
        for c in range(cols):
            if grid[r][c] == 'O':
                distances = [
                    dfs(r, c, 0, -1),  # left
                    dfs(r, c, -1, 0),  # top
                    dfs(r, c, 1, 0),   # bottom
                    dfs(r, c, 0, 1)    # right
                ]
                if distances == query:
                    result.append([r, c])

    return result

```
