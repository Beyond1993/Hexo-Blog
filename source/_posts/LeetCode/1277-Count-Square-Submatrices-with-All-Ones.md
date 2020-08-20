---
title: 1277 Count Square Submatrices with All Ones
date: 2020-02-21 10:00:57
categories: LeetCode
tags:
---

这题就是算 最大正方形 变长.

```java
class Solution {
    public int countSquares(int[][] matrix) {
        int[][] A = new int[matrix.length][matrix[0].length];
        int res = 0;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                if (matrix[i][j] == 1) {
                    if (i > 0 && j > 0) {
                        A[i][j] = Math.min(Math.min(A[i-1][j-1], A[i][j-1]), A[i-1][j]) + 1;
                    } else {
                        A[i][j] = 1;
                    }
                }
                res += A[i][j];
            }
        }
        return res;
    }
}
```

本质就是这题:

https://leetcode.com/problems/maximal-square/


