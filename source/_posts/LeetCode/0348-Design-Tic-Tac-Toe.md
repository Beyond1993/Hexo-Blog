---
title: 0348 Design Tic-Tac-Toe
date: 2019-08-17 00:18:26
categories: LeetCode
tags:
---



```java
/*
如果玩家1在第一行某一列放了一个子，
那么rows[0]自增1，如果玩家2在第一行某一列放了一个子，
则rows[0]自减1，那么只有当rows[0]等于n或者-n的时候，
表示第一行的子都是一个玩家放的，
则游戏结束返回该玩家即可，
其他各行各列，对角线和逆对角线都是这种思路
*/
public class TicTacToe {
    private int[] rows;
    private int[] cols;
    private int diagonal;
    private int antiDiagonal;
    private int n;
    private boolean isFinish;
    private int winer;
    /** Initialize your data structure here. */
    public TicTacToe(int n) {
        rows = new int[n];
        cols = new int[n];
        this.n = n;
        this.isFinish = false;
    }
    
    /** Player {player} makes a move at ({row}, {col}).
        @param row The row of the board.
        @param col The column of the board.
        @param player The player, can be either 1 or 2.
        @return The current winning condition, can be either:
                0: No one wins.
                1: Player 1 wins.
                2: Player 2 wins. */
    public int move(int row, int col, int player) {
        if (isFinish) {
            return this.winer;
        }
        int add = player == 1 ? 1 : -1;
        
        rows[row] += add;
        cols[col] += add;
        
        if (row == col) {
            diagonal += add;
        }
        
        if (row ==  this.n - col - 1) {
           antiDiagonal += add; 
        }
        
        if (Math.abs(rows[row]) == this.n ||
            Math.abs(cols[col]) == this.n ||
            Math.abs(diagonal) == this.n ||
            Math.abs(antiDiagonal) == this.n ) {
                this.winer = player;
                return player;
        }
                     
        return 0;
    }
}

/**
 * Your TicTacToe object will be instantiated and called as such:
 * TicTacToe obj = new TicTacToe(n);
 * int param_1 = obj.move(row,col,player);
 */
```
`
