---
title: 1102 Path With Maximum Minimum Value
date: 2020-06-14 20:51:21
categories: LeetCode
tags:
---

Given a matrix of integers A with R rows and C columns, find the maximum score of a path starting at [0,0] and ending at [R-1,C-1].

The score of a path is the minimum value in that path.  For example, the value of the path 8 →  4 →  5 →  9 is 4.

A path moves some number of times from one visited cell to any neighbouring unvisited cell in one of the 4 cardinal directions (north, east, west, south).


```java
public int maximumMinimumPath(int[][] A) {
        final int[][] DIRS = {{0,1},{1,0},{0,-1},{-1,0}};
        Queue<int[]> pq = new PriorityQueue<>((a, b) -> Integer.compare(b[0], a[0]));
        pq.add(new int[] {A[0][0], 0, 0});
        int maxscore = A[0][0];
        A[0][0] = -1; // visited
        while(!pq.isEmpty()) {
            int[] top = pq.poll();
            int i = top[1], j = top[2], n = A.length, m = A[0].length;
            maxscore = Math.min(maxscore, top[0]);
            if(i == n - 1 && j == m - 1)
                break;
            for(int[] d : DIRS) {
                int newi = d[0] + i, newj = d[1] + j;
                if(newi >= 0 && newi < n && newj >= 0 && newj < m && A[newi][newj]>=0){
                    pq.add(new int[] {A[newi][newj], newi, newj});
                    A[newi][newj] = -1;
                }
            }
        }
        return maxscore;
    }
```
