---
title: 1197 Minimum Knight Moves
date: 2020-04-07 22:19:51
categories:
tags:
---

In an infinite chess board with coordinates from -infinity to +infinity, you have a knight at square [0, 0].

A knight has 8 possible moves it can make, as illustrated below. Each move is two squares in a cardinal direction, then one square in an orthogonal direction.

![](https://assets.leetcode.com/uploads/2018/10/12/knight.png)

Return the minimum number of steps needed to move the knight to the square [x, y].  It is guaranteed the answer exists.

 

Example 1:

Input: x = 2, y = 1
Output: 1
Explanation: [0, 0] → [2, 1]
Example 2:

Input: x = 5, y = 5
Output: 4
Explanation: [0, 0] → [2, 1] → [4, 2] → [3, 4] → [5, 5]
 

Constraints:

|x| + |y| <= 300.


这题就是马走日最少几步, 作为一个象棋爱好者, 真心感觉这题很巧妙.

无权重无向图的最短路径。第一反应是bfs.

但是这题有一个非常巧妙的解法.

重点:
- 不论是第一 二 三 四象限的点，都可以映射到第一象限。
- 没走一步只有两种情况， x - 1, y - 2, 或者 y - 2, x - 1。
- 两个corner case

 
```java
class Solution {
    final int mod = 300; // |x| + |y| <= 300
    public int minKnightMoves(int x, int y) {
        return dfs(Math.abs(x), Math.abs(y), new HashMap<>());
    }
    
    public int dfs(int x, int y, Map<Integer, Integer> map) {
        int index = x * mod + y;
        if (map.containsKey(index)) {
            return map.get(index);
        }
        int ans = 0;
        if (x + y == 0) {
            ans = 0;
        } else if (x + y == 2) {
            ans = 2;
        } else {
            ans = Math.min(dfs(Math.abs(x - 1), Math.abs(y - 2), map),
                          dfs(Math.abs(x - 2), Math.abs(y - 1), map)) + 1;
        }
        map.put(index, ans);
        return ans;
    }
}
```
