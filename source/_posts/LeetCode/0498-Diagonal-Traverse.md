---
title: 0498 Diagonal Traverse
date: 2024-09-25 07:55:08
categories: LeetCode
tags:
---

分别判断四条边，

i == 0, j < n -1
i < m -1 and j = n - 1
i < m - 1 and j == 0
i == m - 1 and j < n - 1


```python
class Solution:
    def findDiagonalOrder(self, mat: List[List[int]]) -> List[int]:
        res = []
        m = len(mat)
        n = len(mat[0])
        direction = 1 # 1 is up right, -1 is down left
        i, j = 0, 0
        for k in range(m * n):
                res.append(mat[i][j])
                if direction == 1 and i == 0 and j < n - 1 :
                    j = j + 1  
                    direction = -direction  
                elif direction == 1 and i < m - 1 and j == n - 1:
                    i = i + 1
                    direction = -direction
                elif direction == -1 and i < m - 1 and j == 0:
                    i = i + 1
                    direction = -direction
                elif direction == -1 and i == m - 1 and j < n - 1:
                     j = j + 1
                     direction = -direction
                elif direction == 1 :
                    i = i - 1
                    j = j + 1
                else:
                    i = i + 1
                    j = j - 1
        return res
```

