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

BFS

能用BFS 的尽量用BFS. 简单不容易出错，python BFS 最好的还是用 collections.deque(),时间复杂度为O(1), 如果用 [], pop(0) 时间复杂度是O(N). 因为要平移元素.

```python
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:
        if not grid:
            return 0

        nr = len(grid)
        nc = len(grid[0])

        num_islands = 0

        for r in range(nr):
            for c in range(nc):
                if grid[r][c] == "1":
                    num_islands += 1
                    grid[r][c] = 0

                    neighbors = collections.deque([])
                    neighbors.append((r,c))
                    while neighbors:
                        row, col = neighbors.popleft()
                        if row - 1 >= 0 and grid[row - 1][col] == "1":
                            neighbors.append((row - 1, col))
                            grid[row - 1][col] = "0"
                        
                        if row + 1 < nr and grid[row + 1][col] == "1":
                            neighbors.append((row + 1,  col))
                            grid[row+1][col] = "0"
                        
                        if col - 1 >= 0 and grid[row][col - 1] == "1":
                            neighbors.append((row, col - 1))
                            grid[row][col - 1] = "0"
                        
                        if col + 1 < nc and grid[row][col + 1] == "1":
                            neighbors.append((row, col + 1))
                            grid[row][col + 1] = "0"
        return num_islands  
```

对于 deque 来说， popleft 就是 bfs
```python
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:

        dire = [[0, 1], [0, -1], [-1, 0], [1, 0]]
        
        def bfs(i, j):
            q = collections.deque()
            q.append((i, j))

            while q: 
                x, y = q.popleft()
                for d in dire:
                    nextX = x + d[0]
                    nextY = y + d[1]
                    if nextX < 0 or nextX == len(grid) or nextY < 0 or nextY == len(grid[0]) or grid[nextX][nextY] == "0":
                        continue
                    q.append((nextX, nextY))
                    grid[nextX][nextY] = "0"
        count = 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == "1":
                    bfs(i, j)
                    count += 1
        return count
```

用 pop() 就是 dfs

```python
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:

        dire = [[0, 1], [0, -1], [-1, 0], [1, 0]]
        
        def bfs(i, j):
            q = collections.deque()
            q.append((i, j))

            while q: 
                x, y = q.pop()
                for d in dire:
                    nextX = x + d[0]
                    nextY = y + d[1]
                    if nextX < 0 or nextX == len(grid) or nextY < 0 or nextY == len(grid[0]) or grid[nextX][nextY] == "0":
                        continue
                    q.append((nextX, nextY))
                    grid[nextX][nextY] = "0"
        count = 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == "1":
                    bfs(i, j)
                    count += 1
        return count
```


711 Number of Dis

