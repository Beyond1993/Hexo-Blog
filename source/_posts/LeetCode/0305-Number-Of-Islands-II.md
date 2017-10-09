---
title: 0305-Number-Of-Islands-II
date: 2017-10-09 02:30:37
categories: LeetCode
tags:
---

200 题的 fellow up 
每次 都有一处水变岛。问每经过一步之后，岛的数量。

题目描述:
A 2d grid map of m rows and n columns is initially filled with water. We may perform an addLand operation which turns the water at position (row, col) into a land. Given a list of positions to operate, count the number of islands after each addLand operation. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example:

Given m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]].
Initially, the 2d grid grid is filled with water. (Assume 0 represents water and 1 represents land).

0 0 0
0 0 0
0 0 0
Operation #1: addLand(0, 0) turns the water at grid[0][0] into a land.

1 0 0
0 0 0   Number of islands = 1
0 0 0
Operation #2: addLand(0, 1) turns the water at grid[0][1] into a land.

1 1 0
0 0 0   Number of islands = 1
0 0 0
Operation #3: addLand(1, 2) turns the water at grid[1][2] into a land.

1 1 0
0 0 1   Number of islands = 2
0 0 0
Operation #4: addLand(2, 1) turns the water at grid[2][1] into a land.

1 1 0
0 0 1   Number of islands = 3
0 1 0
We return the result as an array: [1, 1, 2, 3]

Challenge:

Can you do it in time complexity O(k log mn), where k is the length of the positions?


```java
class UnionFind {
    private int count;
    private int[] father;
    UnionFind(int n) {
        father = new int[n];
        for (int i = 0; i < n; i++) {
            father[i] = i;
        }
    }
        
    private int find(int a) {
        if (father[a] == a) {
            return a;
        }
        return father[a] = find(father[a]);
    }
    
    public void connect(int a, int b) {
        int father_a = find(a);
        int father_b = find(b);
        
        if (father_a != father_b) {
            father[father_b] = father_a;
            count--;
        }
    }
    
    public void setCount(int x) {
        count = x;
    }
    
    public int getCount() {
        return count;
    }

}

public class Solution {
    public List<Integer> numIslands2(int m, int n, int[][] positions) {
        int k = positions.length;
        if (k == 0) {
            return null;
        }
        int[][] grid = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                grid[i][j] = 0;
            }
        }
        
        UnionFind uf = new UnionFind(m * n);
        uf.setCount(0);
        List<Integer> list = new ArrayList<Integer>();
        for (int i = 0; i < k; i++) {
            uf.setCount(uf.getCount() + 1);
            int row = positions[i][0];
            int col = positions[i][1];
            grid[row][col] = '1';
            if (row - 1 >= 0 && grid[row - 1][col] == '1') {
                uf.connect(row * n + col, (row - 1) * n + col);
            }
            
            if (row + 1 < m && grid[row + 1][col] == '1') {
                uf.connect(row * n + col, (row + 1) * n + col);
            }
            
            if (col - 1 >= 0 && grid[row][col - 1] == '1') {
                uf.connect(row * n + col, row * n + col -1);
            }
            
            if (col + 1 < n && grid[row][col + 1] == '1') {
                uf.connect(row * n + col, row * n + col + 1);
            }
            
            list.add(uf.getCount());
        }
        return list;
    } 
}
```
