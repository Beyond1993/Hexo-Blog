---
title: 723 Candy Crush
date: 2021-03-01 00:48:11
categories: LeetCode
tags:
---

This question is about implementing a basic elimination algorithm for Candy Crush.

Given a 2D integer array board representing the grid of candy, different positive integers board[i][j] represent different types of candies. A value of board[i][j] = 0 represents that the cell at position (i, j) is empty. The given board represents the state of the game following the player's move. Now, you need to restore the board to a stable state by crushing candies according to the following rules:

If three or more candies of the same type are adjacent vertically or horizontally, "crush" them all at the same time - these positions become empty.
After crushing all candies simultaneously, if an empty space on the board has candies on top of itself, then these candies will drop until they hit a candy or bottom at the same time. (No new candies will drop outside the top boundary.)
After the above steps, there may exist more candies that can be crushed. If so, you need to repeat the above steps.
If there does not exist more candies that can be crushed (ie. the board is stable), then return the current board.
You need to perform the above rules until the board becomes stable, then return the current board.



```java
class Solution {
    Queue<int[]> index = new LinkedList<>();
    public int[][] candyCrush(int[][] board) {
        while(check(board)){
            crush(board);
            gravity(board);
            
        }
        return board;
    }
    
    public boolean check(int[][] board){
        boolean isChange = false;
        
        for(int i=0;i<board.length;i++){
            for(int j=0;j<board[0].length-2;j++){
                if(Math.abs(board[i][j])!= 0 && Math.abs(board[i][j])==Math.abs(board[i][j+1]) && Math.abs(board[i][j])==Math.abs(board[i][j+2])){
                    isChange = true;
                    int temp = -1* Math.abs(board[i][j]);
                    board[i][j]= temp;
                    board[i][j+1]= temp;
                    board[i][j+2]= temp;
                }
            }
        }
        
        
        for(int j =0;j<board[0].length;j++){
            for(int i =0;i<board.length-2;i++){
                if(Math.abs(board[i][j])!= 0 && Math.abs(board[i][j])==Math.abs(board[i+1][j]) && Math.abs(board[i][j])==Math.abs(board[i+2][j])){
                     isChange = true;
                    int temp = -1* Math.abs(board[i][j]);
                    board[i][j]= temp;
                    board[i+1][j]= temp;
                    board[i+2][j]= temp;
                }
            }
        }
        return isChange;
    }
    
    
    public void crush(int[][] board){
        for(int i=0;i<board.length;i++){
            for(int j=0;j<board[i].length;j++){
                if(board[i][j]<0){
                    board[i][j]=0;
                    index.add(new int[]{i,j});
            }
            }
        }
    }
    
    public void gravity(int[][] board){
       while(!index.isEmpty()) {
            int[] dir = index.poll();
            int row = dir[0];
            int col = dir[1];
            
            while(row>0) {
                int temp = board[row-1][col];
                board[row][col]= temp;
                board[row-1][col]= 0;
                row = row-1;
            }
        }
    }
}
```
