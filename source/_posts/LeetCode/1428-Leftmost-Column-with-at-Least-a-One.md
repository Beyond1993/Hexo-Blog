---
title: 1428 Leftmost Column with at Least a One
date: 2021-02-28 14:23:01
categories: LeetCode
tags:
---


题目大意是给一个二维矩阵matrix，里面只有0和1两种数字，matrix的每一行的数字都是非递减的（但是每一列并不是非递减）。你不能直接访问这个matrix，但是你可以通过给的接口访问matrix的一些东西，比如dimensions()可以拿到matrix的dimension尺寸，get(x, y)可以拿到某一个坐标上的值。请你返回这个矩阵里面最左边的包含起码一个1的column的index。若这个column不存在则返回-1。

一般解法:
```java
/**
 * // This is the BinaryMatrix's API interface.
 * // You should not implement it, or speculate about its implementation
 * interface BinaryMatrix {
 *     public int get(int row, int col) {}
 *     public List<Integer> dimensions {}
 * };
 */

class Solution {   
    
    public int leftMostColumnWithOne(BinaryMatrix  bm) {
        
        int rows = bm.dimensions().get(0);
        int cols = bm.dimensions().get(1);
        
        int index = cols;
        
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (bm.get(i, j) == 1) {
                    index = Math.min(index, j);
                    break;
                }
            }
        }
        return index == cols ? -1 : index;
    }
    
}
```
