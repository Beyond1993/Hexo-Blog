---
title: 0407 Trapping Rain Water II
date: 2019-06-23 23:41:28
categories: LeetCode
tags:
---

这题是不断把边界从四周往中间拓展的过程，相当于把边界的最低点往中间移，这样每个点只需要访问一次。

和边界相连的点以边界的点为最低点，把中间的点变成和边界点一样高，相当于边界往里面延伸

```java
class Solution {
    
    int[] dx = {1,-1,0,0};
    int[] dy = {0,0,1,-1};
    public int trapRainWater(int[][] heightMap) {
        if (heightMap == null || heightMap.length == 0) return 0;
        PriorityQueue<int[]> pq = new PriorityQueue<int[]> (
            (a, b) -> a[2] - b[2]
        );

        boolean[][] visited = new boolean[heightMap.length][heightMap[0].length];

        for (int i = 0; i < heightMap.length; i++) {
            pq.add(  new int[]{i, 0, heightMap[i][0]} );
            pq.add(new int[]{i, heightMap[0].length -1, heightMap[i][heightMap[0].length - 1]});
            visited[i][0] = true;
            visited[i][heightMap[0].length - 1] = true;
        }

        for (int j = 0; j < heightMap[0].length; j++) {
            pq.add(new int[]{0, j, heightMap[0][j]});
            pq.add(new int[]{heightMap.length - 1, j, heightMap[heightMap.length - 1][j]});
            visited[0][j] = true;
            visited[heightMap.length - 1][j] = true;
        }
        int area = 0;          
        while(!pq.isEmpty()) {
            int[] cur = pq.poll();
            for (int i = 0; i < 4; i++) {
                int nextX = cur[0] + dx[i];
                int nextY = cur[1] + dy[i];
                if (nextX <= 0 || nextX >= heightMap.length - 1 || nextY <= 0 || nextY >= heightMap[0].length - 1
                   || visited[nextX][nextY]) {
                    continue;
                } 
                visited[nextX][nextY] = true;
                int nextHeight = heightMap[nextX][nextY];
                if (nextHeight >= cur[2]) {
                    pq.add(new int[]{nextX, nextY, nextHeight});
                } else {
                    area += cur[2] - nextHeight;
                    pq.add(new int[]{nextX, nextY, cur[2]});
                }

            }
        }
        return area;
    }
}


// [1,4,3,1,3,2],
// [3,3,3,3,3,4], water = 3
// [2,3,3,2,3,1]


// [1,2,3,3,1]
// [2,1,1,1,2]
// [1,2,3,3,1]

// [1,2,3,3,1]
// [2,2.,2,2.,2]
// [1,2,3,3,1]


// [1,2,3,3,1]
// [2,1,1,1,1]
// [1,2,3,3,1]

// 1,1,1,1,2,2,2,2,[1,1,2],[1,3,2],3,3,3,3

// cur = [0,0,1]
// 1,1,1,1
    
// [0,1,2] ==>  sum = 3

// [1,0,2]  

// 1,1,1,1,1, 1

```
