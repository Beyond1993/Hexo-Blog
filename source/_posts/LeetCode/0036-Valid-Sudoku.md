---
title: 0036 Valid Sudoku
date: 2018-01-09 01:28:07
categories: LeetCode
tags:
---


数独是否有解，对于同一行，同一列的情况，比较好判断，每一行，每一列都搞一个hashmap, 
对于一个 box 的id,

 
idx = (r // 3) * 3 + c // 3

比如[5, 6] index = idx 3 + 2 = 5, 是 第5个box

```python
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        N = 9

        # Use hash set to record the status
        rows = [set() for _ in range(N)]
        cols = [set() for _ in range(N)]
        boxes = [set() for _ in range(N)]

        for r in range(N):
            for c in range(N):
                val = board[r][c]
                # Check if the position is filled with number
                if val == ".":
                    continue

                # Check the row
                if val in rows[r]:
                    return False
                rows[r].add(val)

                # Check the column
                if val in cols[c]:
                    return False
                cols[c].add(val)

                # Check the box
                idx = (r // 3) * 3 + c // 3
                if val in boxes[idx]:
                    return False
                boxes[idx].add(val)

        return True
```
