---
title: 0085 Maximal Rectangle
date: 2018-07-14 18:10:57
categories: LeetCode
tags:
---

Given a 2D binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.

Example:

Input:
[
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]
Output: 6


```java
public class Solution {
    private int getLargestRecrtangle(int[] heights) {
        Stack<Integer> s = new Stack<Integer>();
        int max = 0;
        for (int i = 0; i <= heights.length; i++) {
            int cur = i == heights.length ? -1 : heights[i];
            while(!s.isEmpty() && cur <= heights[s.peek()]) {
                int h = heights[s.pop()];
                int w = s.isEmpty() ? i : i - s.peek() - 1;
                max = Math.max(max, h * w);
            }
            s.push(i);
        }
        return max;
    }
    public int maximalRectangle(char[][] matrix) {
        if (matrix.length == 0) {
            return 0;
        }
        int row = matrix.length;
        int col = matrix[0].length;
        int[] input = new int[col];
        int max = 0;
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                if (matrix[i][j] == '0') {
                    input[j] = 0;
                } else {
                    input[j] += matrix[i][j] - '0'; 
                }
            }
            
            max = Math.max(max, getLargestRecrtangle(input));
        }
       //System.out.println(Arrays.toString(input));
        return max;
    }
}
```
