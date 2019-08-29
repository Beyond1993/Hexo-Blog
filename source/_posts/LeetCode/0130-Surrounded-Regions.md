---
title: 0130 Surrounded Regions
date: 2017-12-26 07:01:42
categories: LeetCode
tags:
---



Union Find, 把边界的 0 Union 到 dummy node 上。

dummy 的 father 有可能也会变

[0, 0, 0]
[0, 0, 0]
[0, 0, 0]

```java
class Solution {
    
    class UnionFind {
        int[] father;
        
        public UnionFind(int n) {
            father = new int[n];
            for (int i = 0; i < n; i++) {
                father[i] = i;
            }
        }
        
        public int find(int a) {
            if (father[a] == a) {
                return a;
            }
            return father[a] = find(father[a]); 
        }
        // union b to a
        public void union(int a, int b) {
            int father_a = find(a);
            int father_b = find(b);
            
            father[father_b] = father_a;
        }
        
        boolean isConnected(int a, int b) {
            return find(a) == find(b);
        }
    }
    
    public void solve(char[][] board) {
        if (board.length == 0) {
            return;
        }
        int n = board.length;
        int m = board[0].length;
        UnionFind uf = new UnionFind(n * m + 1); // one more dummy node
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == 'O') {
                    //board 
                    if (i == n - 1 || j == m -1 || i == 0 || j == 0) {
                        uf.union(n * m, i * m + j);
                    } else {
                    
                        //up
                        if ( board[i-1][j] == 'O' ) { uf.union(i * m + j, (i - 1) * m + j);}
                        //down
                       if (board[i+1][j] == 'O') { uf.union(i * m + j, (i + 1) * m + j);}

                        //left
                        if (board[i][j - 1] == 'O') { uf.union(i * m + j, i * m + j - 1);}

                        //right
                       if (board[i][j+1] == 'O') { uf.union(i * m + j, i * m + j + 1); }   
                    } 
                }
            }
        }
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == 'O' && !uf.isConnected(i * m + j, n * m)) {
                    board[i][j] = 'X';
                }
            }
        }
    }
}
```


dfs

把边界的 0 变成 -1

```java
class Solution {
    int[] dx = {-1, 1, 0, 0};
    int[] dy = {0, 0, 1, -1};
    public void solve(char[][] board) {
        if (board.length == 0) {
            return;
        }
        
        for (int i = 0; i < board.length; i++) {
            if (board[i][0] == 'O') {
                dfs(i, 0, board);
                dfs(i, board[0].length - 1, board);
            }
        }
        
        for (int j = 0; j < board[0].length; j++) {
            if (board[0][j] == 'O') {
                dfs(0, j, board);
                dfs(board.length -1, j, board);
            }
        }
        
        for (int i = 0; i < board.length; i++)
            for (int j = 0; j < board[0].length; j++) {
                if (board[i][j] == 'O') {
                    board[i][j] = 'X';
                }
                
                if (board[i][j] == 'A') {
                    board[i][j] = 'O';
                }
            }
        
    }

    private void dfs (int x, int y, char[][] board) {
        if (x < 0 || x >= board.length || y < 0 
            || y >= board[0].length || board[x][y] == 'X' 
            || board[x][y] == 'A') {
            return;
        }
        if (board[x][y] == 'O') {
            board[x][y] = 'A';
        }
        for (int i = 0; i < 4; i++) {
            dfs(x + dx[i], y + dy[i], board);
        } 
    }
}
```


