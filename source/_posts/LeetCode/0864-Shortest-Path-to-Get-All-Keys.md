---
title: 0864 Shortest Path to Get All Keys
date: 2019-09-12 01:06:00
categories: LeetCode
tags:
---

We are given a 2-dimensional grid. "." is an empty cell, "#" is a wall, "@" is the starting point, ("a", "b", ...) are keys, and ("A", "B", ...) are locks.

We start at the starting point, and one move consists of walking one space in one of the 4 cardinal directions.  We cannot walk outside the grid, or walk into a wall.  If we walk over a key, we pick it up.  We can't walk over a lock unless we have the corresponding key.

For some 1 <= K <= 6, there is exactly one lowercase and one uppercase letter of the first K letters of the English alphabet in the grid.  This means that there is exactly one key for each lock, and one lock for each key; and also that the letters used to represent the keys and locks were chosen in the same order as the English alphabet.

Return the lowest number of moves to acquire all keys.  If it's impossible, return -1.

 

Example 1:

Input: ["@.a.#","###.#","b.A.B"]
Output: 8
Example 2:

Input: ["@..aA","..B#.","....b"]
Output: 6

Note:

1. 1 <= grid.length <= 30
2. 1 <= grid[0].length <= 30
3. grid[i][j] contains only '.', '#', '@', 'a'-'f' and 'A'-'F'
4. The number of keys is in [1, 6].  Each key has a different letter and opens exactly one lock.


```java
class Solution {
    public int shortestPathAllKeys(String[] g) {
        int[] start = new int[2];
        StringBuilder[] grid = new StringBuilder[g.length];
        int keyNum = 0;
        for (int i = 0; i < g.length; i++) {
            grid[i] = new StringBuilder(g[i]);
            for (int j = 0; j < g[i].length(); j++) {
                if (g[i].charAt(j) == '@') {
                    start[0] = i;
                    start[1] = j;
                }
                
                if (g[i].charAt(j) >= 'a' && g[i].charAt(j) <= 'f') {
                    keyNum++;
                }
            }
        }
        System.out.println(keyNum);
        int[] dx = {1, -1,0,0};
        int[] dy = {0,0,-1,1};
        char[] keys = new char[6];
        Queue<int[]> q = new LinkedList<int[]>();
        int steps = 0;
       // System.out.println(start[0] + " " + start[1]);
        q.offer(start);
        
        while(!q.isEmpty()) {
            
           int size = q.size();
           steps++;
           for (int s = 0; s < size; s++) {
               int[] cur = q.poll();
               
               int n = 0;
               for (int i = 0; i < 4; i++) {
                   int nextX = cur[0] + dx[i];
                   int nextY = cur[1] + dy[i];
                   
                   if (nextX < 0 || nextY < 0 || nextX >= grid.length || nextY >= grid[0].length() 
                       || grid[nextX].charAt(nextY) == '#') {
                       continue;
                   }
                   //System.out.println(nextX + " " + nextY);
                   if ( grid[nextX].charAt(nextY) >= 'a' && grid[nextX].charAt(nextY) <= 'f') {
                       keys[grid[nextX].charAt(nextY) - 'a'] += 1;
                       grid[nextX].setCharAt(nextY, '.');
                       keyNum--;
                       n++;
                   } 
                   
                   if ( grid[nextX].charAt(nextY) >= 'A' && grid[nextX].charAt(nextY) <= 'F') {
                       
                       if (keys[grid[nextX].charAt(nextY) - 'A'] > 0) {
                           keys[grid[nextX].charAt(nextY) - 'A'] -= 1;
                           grid[nextX].setCharAt(nextY, '.');
                       } else {
                           continue;
                       }
                   } 
                   q.add(new int[]{nextX, nextY});
               }
               steps += 2 * (n-1) - 1;
               if (keyNum == 0) return steps; 
           }
        }
        return keyNum == 0 ? steps : -1;
    }
}

/*
@.a.#
###.#
b.A.B

2 * n + 1
a
@ b
c
["@a...",
" b###A",
*/
```

正常bfs 计算离当前点层数，但是这题有回退的可能性。


