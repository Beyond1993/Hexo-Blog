---
title: 0037 Sudoku Solver
date: 2018-02-20 01:28:45
categories: LeetCode
tags:
---


```python
class Solution:
    def solveSudoku(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        if not board:
            return
        self.backtrack(board)
    
    def backtrack(self, board):
        # Find the next empty cell
        for i in range(9):
            for j in range(9):
                if board[i][j] == '.':
                    # Try every digit from '1' to '9'
                    for c in '123456789':
                        if self.isValid(board, i, j, c):
                            board[i][j] = c
                            if self.backtrack(board):  # Recursively solve
                                return True
                            else:
                                board[i][j] = '.'  # Backtrack
                    return False  # If no valid digit found, return False to backtrack
        return True  # If no empty cells, puzzle is solved

    def isValid(self, board, row, col, c):
        # Check row and column
        for i in range(9):
            if board[row][i] == c or board[i][col] == c:
                return False
        
        # Check subgrid (3x3)
        start_row, start_col = (row // 3) * 3, (col // 3) * 3
        for i in range(start_row, start_row + 3):
            for j in range(start_col, start_col + 3):
                if board[i][j] == c:
                    return False
        
        return True
```

```python
class Solution:
    def solveSudoku(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        # Create hashmaps (sets) for rows, columns, and 3x3 subgrids
        rows = [set() for _ in range(9)]
        cols = [set() for _ in range(9)]
        boxes = [set() for _ in range(9)]
        
        # Pre-fill the sets based on the current board state
        for r in range(9):
            for c in range(9):
                if board[r][c] != '.':
                    num = board[r][c]
                    rows[r].add(num)
                    cols[c].add(num)
                    boxes[(r // 3) * 3 + c // 3].add(num)
        
        self.backtrack(board, rows, cols, boxes)
    
    def backtrack(self, board, rows, cols, boxes):
        # Find the next empty cell
        for r in range(9):
            for c in range(9):
                if board[r][c] == '.':
                    # Try every digit from '1' to '9'
                    for num in '123456789':
                        if self.isValid(r, c, num, rows, cols, boxes):
                            board[r][c] = num
                            # Mark the current number in the corresponding sets
                            rows[r].add(num)
                            cols[c].add(num)
                            boxes[(r // 3) * 3 + c // 3].add(num)
                            
                            if self.backtrack(board, rows, cols, boxes):
                                return True
                            else:
                                # Backtrack: remove the number and reset the cell
                                board[r][c] = '.'
                                rows[r].remove(num)
                                cols[c].remove(num)
                                boxes[(r // 3) * 3 + c // 3].remove(num)
                    return False  # No valid number found, backtrack
        return True  # Solved if no empty cells

    def isValid(self, r, c, num, rows, cols, boxes):
        # Check if the number is already in the row, column, or subgrid
        return num not in rows[r] and num not in cols[c] and num not in boxes[(r // 3) * 3 + c // 3]
```


