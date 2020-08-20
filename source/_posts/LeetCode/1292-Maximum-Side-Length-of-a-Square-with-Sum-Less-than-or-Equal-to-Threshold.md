---
title: 1292 Maximum Side Length of a Square with Sum Less than or Equal to Threshold
date: 2020-08-20 10:10:15
categories: LeetCode
tags:
---


```java
class Solution {
    public int maxSideLength(int[][] mat, int threshold) {
        int[][] preSum = new int[mat.length][mat[0].length];
        preSum[0][0] = mat[0][0];
        for (int i = 1; i < mat.length; i++) {
            preSum[i][0] = preSum[i-1][0] + mat[i][0];
        }
        for (int i = 1; i < mat[0].length; i++) {
            preSum[0][i] = preSum[0][i-1] + mat[0][i];
        }
        for (int i = 1; i < mat.length; i++) {
            for (int j = 1; j < mat[0].length; j++) {
                preSum[i][j] = preSum[i][j-1] + 
                    preSum[i-1][j] + mat[i][j] - preSum[i-1][j-1];
            }
        }
        int len = Math.min(mat.length, mat[0].length);
        int res = 0;
        for (int i = 0; i < mat.length; i++) {
            for(int j = 0; j < mat[0].length; j++) {
                if (mat[i][j] > threshold)
                    continue;
                if (mat[i][j] <= threshold) {
                    res = Math.max(res, 1);
                }
                for (int k = 2; k <= len; k++) {
                    if (i + k - 1 >= mat.length 
                        || j + k - 1 >= mat[0].length) continue;
                    
                    int up = (i - 1 < 0) ? 0 : preSum[i-1][j+k-1];
                    int left = (j - 1 < 0) ? 0 : preSum[i+k-1][j-1];
                    int leftUp = (i - 1 < 0) || j-1 < 0 ? 0 : preSum[i-1][j-1];
                    
                    int sum = preSum[i+k-1][j+k-1] - up - left + leftUp;
                    if (sum <= threshold) {
                        res = Math.max(k, res);
                    }
                }
            }
        }
        return res;
    }
}
```
