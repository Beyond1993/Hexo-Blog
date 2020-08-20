---
title: 0835 Image Overlap
date: 2020-05-31 23:56:04
categories: LeetCode
tags:
---

Two images A and B are given, represented as binary, square matrices of the same size.  (A binary matrix has only 0s and 1s as values.)

We translate one image however we choose (sliding it left, right, up, or down any number of units), and place it on top of the other image.  After, the overlap of this translation is the number of positions that have a 1 in both images.

(Note also that a translation does not include any kind of rotation.)

What is the largest possible overlap?

Example 1:

Input: A = [[1,1,0],
            [0,1,0],
            [0,1,0]]
       B = [[0,0,0],
            [0,1,1],
            [0,0,1]]
Output: 3
Explanation: We slide A to right by 1 unit and down by 1 unit.
Notes: 
1. 1 <= A.length = A[0].length = B.length = B[0].length <= 30
2. 0 <= A[i][j], B[i][j] <= 1


暴力解法: 找到A中的每一个点，在以这个点为起点，遍历B 中每一个点。时间复杂度 O(n^4)
```java
class Solution {
    public int largestOverlap(int[][] A, int[][] B) {
        int res=0;
        
        for(int r = 0; r < A.length; r++) {
            for(int c = 0; c < A[0].length; c++) {
                res = Math.max(res,compare(A,B,r,c));
                res = Math.max(res,compare(B,A,r,c));
            }
        }
        
        return res;
    }
    
    private int compare(int[][] A, int[][] B, int r, int c) {
        int count=0;
        for(int i = 0; i < A.length && i + r < A.length; i++)
            for(int j = 0; j < A[0].length && j + c < A[0].length; j++)
                if(1 == A[i][j] && 1 == B[i+r][j+c])
                    count++;
        return count;
    }
}
```

利用稀疏矩阵的特点，只关心1的位置，取A和B中的任意两个1，横向平移其横坐标之差，竖向平移其纵坐标之差，一定可以重合。
所以只要是**横纵坐标差**相同的两对儿位置，一定是在同一次平移上。
用HashMap 来建立坐标差值和其出现次数之间的映射。
```java
class Solution {
    public int largestOverlap(int[][] A, int[][] B) {
        int res = 0, n = A.length;
        List<int[]> listA = new ArrayList<>();
        List<int[]> listB = new ArrayList<>();
        Map<String, Integer> diffCnt = new HashMap<>();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (A[i][j] == 1) listA.add(new int[]{i, j});
                if (B[i][j] == 1) listB.add(new int[]{i, j});
            }
        }
        for (int[] a : listA) {
            for (int[] b : listB) {
                String key = (a[0] - b[0]) + "-" + (a[1] - b[1]);
                diffCnt.put(key, diffCnt.getOrDefault(key, 0) + 1);
            }
        }
        for (int diff : diffCnt.values()) {
            res = Math.max(res, diff);
        }
        return res;
    }
}
```

