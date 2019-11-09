---
title: 0289 Game of Life
date: 2019-11-04 03:03:56
categories: LeetCode
tags:
---

According to the Wikipedia's article: "The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970."

Given a board with m by n cells, each cell has an initial state live (1) or dead (0). Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules (taken from the above Wikipedia article):

Any live cell with fewer than two live neighbors dies, as if caused by under-population.
Any live cell with two or three live neighbors lives on to the next generation.
Any live cell with more than three live neighbors dies, as if by over-population..
Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
Write a function to compute the next state (after one update) of the board given its current state. The next state is created by applying the above rules simultaneously to every cell in the current state, where births and deaths occur simultaneously.

Example:

Input: 
[
  [0,1,0],
  [0,0,1],
  [1,1,1],
  [0,0,0]
]
Output: 
[
  [0,0,0],
  [1,0,1],
  [0,1,1],
  [0,1,0]
]
Follow up:

Could you solve it in-place? Remember that the board needs to be updated at the same time: You cannot update some cells first and then use their updated values to update other cells.
In this question, we represent the board using a 2D array. In principle, the board is infinite, which would cause problems when the active area encroaches the border of the array. How would you address these problems?

1 代表活着的细胞
0 代表死细胞


一共有四条规则:

1. 如果活细胞周围八个位置的活细胞数少于两个，则该位置活细胞死亡

2. 如果活细胞周围八个位置有两个或三个活细胞，则该位置活细胞仍然存活

3. 如果活细胞周围八个位置有超过三个活细胞，则该位置活细胞死亡

4. 如果死细胞周围正好有三个活细胞，则该位置死细胞复活

状态机

in place 的解法就是 下一个状态怎么存.

低位记录当前状态保持不变, 高位记录下一个状态。

```java
class Solution {
    public int getLiveNeighbors(int[][] board, int x, int y) {
        int[] dx = {-1, 0, 1};
        int[] dy = {-1, 0, 1};
        int count = 0;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (dx[i] == 0 && dy[j] == 0) {
                    continue;
                }
                if (x + dx[i] < 0 || x + dx[i] >= board.length 
                    || y + dy[j] < 0 || y + dy[j] >= board[0].length) {
                    continue;
                }
                
                count += board[x+dx[i]][y+dy[j]] & 1;
                
            }
        }
        return count;
    }
    
    public void gameOfLife(int[][] board) {
        
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                int liveNeighbors = getLiveNeighbors(board, i, j);
                
                if ( (board[i][j] & 1)  == 1 && liveNeighbors < 2) {
                    board[i][j] = 1; //01
                }
                
                if ( (board[i][j] & 1) == 1 && (liveNeighbors == 2 || liveNeighbors == 3)) {
                    board[i][j] = 3; // 11
                }
                
                if ( (board[i][j] & 1) == 1 && liveNeighbors > 3) {
                    board[i][j] = 1; //01
                }
                
                if ( (board[i][j] & 1) == 0 && liveNeighbors == 3) {
                    board[i][j] = 2; //10
                }
            }
        }
        
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                board[i][j] = board[i][j] >> 1;
            }
        }
    }
}
```




