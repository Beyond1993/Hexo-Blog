---
title: 0079-Word-Search
date: 2017-10-16 07:28:47
categories: LeetCode
tags:
---

Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

For example,
Given board =

[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
word = "ABCCED", -> returns true,
word = "SEE", -> returns true,
word = "ABCB", -> returns false.



这是一题非常非常经典的矩阵回溯搜索的题。可以总结出一套递归搜索模板。



思路：先遍历矩阵，找到和字符串头相同的元素，开始回溯搜索。

时间复杂度 M * N * 4 ^ len, (len 是单词长度)

```python
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        visited = set()
        dire = [[0, 1], [0, -1], [1, 0], [-1, 0]]

        def dfs(i, j, path, board, word):
            ## 要先判断 这个path 和 word 之间的关系，因为这时候可能还没有到边界条件判断
            if len(path) == len(word):
                return path == word

            if i < 0 or i >= len(board) or j < 0 or j >= len(board[0]) or (i, j) in visited or board[i][j] != word[len(path)]:
                return False
            
            visited.add((i, j))
            path += board[i][j]
            for d in dire:
                nextI = i + d[0]
                nextJ = j + d[1]
                isValid = dfs(nextI, nextJ, path, board, word)
                if isValid:
                    return True
            path = path[:-1]
            visited.remove((i, j))
            return False

        for i in range(len(board)):
            for j in range(len(board[0])):
                if board[i][j] == word[0]:
                    isValid = dfs(i, j, "", board, word)
                    if isValid: return True

        return False
```

精简版的:
```python
from typing import List

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        visited = set()
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        def dfs(i, j, index):
            # If the index matches the length of the word, we've found the word
            if index == len(word):
                return True
            
            # Check boundaries and visited status
            if (i < 0 or i >= len(board) or j < 0 or j >= len(board[0]) or 
                (i, j) in visited or board[i][j] != word[index]):
                return False
            
            # Mark the cell as visited
            visited.add((i, j))
            
            # Explore all directions
            for d in directions:
                nextI = i + d[0]
                nextJ = j + d[1]
                if dfs(nextI, nextJ, index + 1):
                    return True
            
            # Backtrack: unmark the cell
            visited.remove((i, j))
            return False

        # Try to start the DFS from each cell
        for i in range(len(board)):
            for j in range(len(board[0])):
                if board[i][j] == word[0]:  # Start only if the first letter matches
                    if dfs(i, j, 1):  # Start with index 1 since we already matched word[0]
                        return True

        return False
```

http://47.113.101.198/2020/01/01/LeetCode/0212-Word-Search-II/


