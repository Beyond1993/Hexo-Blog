---
title: 0304 Range Sum Query 2D - Immutable
date: 2019-08-19 00:12:01
categories: LeetCode
tags:
---


```java
public class NumMatrix {
    private int sum[][];
    
    public NumMatrix(int[][] matrix) {
        if (matrix == null || matrix.length == 0) {
            return;
        } 
        int m = matrix.length;
        int n = matrix[0].length;
        
        sum = new int[m][n];
        sum[0][0] = matrix[0][0];
        for (int i = 1; i < matrix.length; i++) {
            sum[i][0] = sum[i-1][0] + matrix[i][0];
        }
        
        for (int j = 1; j < matrix[0].length; j++) {
            sum[0][j] = sum[0][j-1] + matrix[0][j];
        }
        
        for (int i = 1; i < matrix.length; i++) {
            for (int j = 1; j < matrix[0].length; j++) {
                sum[i][j] = matrix[i][j] + sum[i-1][j] + sum[i][j-1] -sum[i-1][j-1];
                System.out.print(sum[i][j] + " ");
            }
            System.out.println();
        }
  
        
    }
    
    public int sumRegion(int row1, int col1, int row2, int col2) {
        System.out.println(sum[row2][col2]);
        if (row1 == 0 && col1 == 0) return sum[row2][col2];
        if (row1 == 0) return sum[row2][col2] - sum[row2][col1-1];
        if (col1 == 0) return sum[row2][col2] - sum[row1-1][col2];
        return sum[row2][col2] - sum[row1-1][col2] - sum[row2][col1-1] + sum[row1-1][col1-1];
    }
}
```
从来就没有考虑过交叉点的问题， 坐标一直是格子。

row1, col1 那个格子的是要被计算的，所以是 row1 - 1, col1 - 1 

