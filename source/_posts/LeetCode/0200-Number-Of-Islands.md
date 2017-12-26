---
title: 0200-Number-Of-Islands
date: 2018-01-01 23:03:41
categories: LeetCode
tags:
---
200 Number of Island

题目描述：
Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

11110
11010
11000
00000
Answer: 1

Example 2:

11000
11000
00100
00011
Answer: 3

思路一：DFS， 遇到一个1， 
```java
public class Solution {  
      
    public int numIslands(char[][] grid) {  
        if (grid.length == 0 || grid[0].length == 0) return 0;      
        int ans = 0;  
        for (int i = 0; i < grid.length; i++) {  
            for (int j = 0; j < grid[0].length; j++) {  
                if (grid[i][j] != '1') continue;  
                ans++;  
                dfs(grid, i, j);  
            }  
        }  
        return ans;  
    }  

    public void dfs(char[][] grid, int i, int j) {  
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length) 
            return;  
        if (grid[i][j] == '1') {  
            grid[i][j] = '2';  
            dfs(grid, i - 1, j);  
            dfs(grid, i + 1, j);  
            dfs(grid, i, j - 1);  
            dfs(grid, i, j + 1);  
        }  
    }  
}  
```
思路二: Union Find

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
    
    private int find_father(int a) {
        if (father[a] == a) {
            return a;
        }
        return father[a] = find_father(father[a]);
    }
    
    public void connect(int a, int b) {
        int father_a = find_father(a);
        int father_b = find_father(b);
        if (father_a != father_b) {
            father[father_a] = father_b;
            count--;
        }
    }
    
    public void set_Count(int a) {
        count = a;
    }
    
    public int get_Count() {
        return count;
    }
}

public class Solution {
    public int numIslands(char[][] grid) {
        int m = grid.length;
        if (m == 0) {
            return 0;
        }
        int n = grid[0].length;
        int total = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1') {
                    total++;
                }
            }
        }
        UnionFind uf = new UnionFind(n * m);
        uf.set_Count(total);
    
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1') {
                    if (i - 1 >= 0 && grid[i-1][j] == '1') {
                        uf.connect(i * n + j, (i - 1) * n + j);
                    }
                    
                    if (i + 1 < m && grid[i+1][j] == '1') {
                        uf.connect(i * n + j, (i + 1) * n + j);
                    }
                    
                    if (j - 1 >= 0 && grid[i][j-1] == '1') {
                        uf.connect(i * n + j, i * n + j -1);
                    }
                    
                    if (j + 1 < n && grid[i][j+1] == '1') {
                        uf.connect(i * n + j, i * n + j + 1);
                    }
                }
            }
        }

        return uf.get_Count();
    }
}
```




