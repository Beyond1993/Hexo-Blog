---
title: 0048 Rotate Image
date: 2019-10-18 00:35:17
categories: LeetCode
tags:
---





```java
class Solution {
    public void rotate(int[][] matrix) {
        if (matrix==null || matrix.length==0) {
            return;
        }
        rotateHelper(matrix,0,matrix.length);
    }
    private void rotateHelper(int[][] matrix,int offset,int size) {
        if (size == 1||size==0) {
            return;
        }
        int[] temp = new int[size-1];
        for (int i=0;i<size-1;i++) {
            //reserve up
            temp[i] = matrix[offset][offset+i];
            //left -> up
            matrix[offset][offset+i] = matrix[offset+size-1-i][offset];
            //bottom->left
            matrix[offset+size-1-i][offset] = matrix[offset+size-1][offset+size-1-i];
            //right->bottom
            matrix[offset+size-1][offset+size-1-i] = matrix[offset+i][offset+size-1];
            //up->right
            matrix[offset+i][offset+size-1] = temp[i];
        }
        rotateHelper(matrix,offset+1,size-2);
    }
}
```
