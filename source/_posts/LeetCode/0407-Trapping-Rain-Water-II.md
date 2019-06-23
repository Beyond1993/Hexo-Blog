---
title: 0407 Trapping Rain Water II
date: 2019-06-23 23:41:28
categories: Leetcode
tags:
---


```java
class Solution {
    int[] dx = {1, -1, 0, 0};
    int[] dy = {0, 0, 1, -1};
    
    public int trapRainWater(int[][] heightMap) {
        if (heightMap == null || heightMap.length == 0) return 0;
        PriorityQueue<int[]> pq = new PriorityQueue<int[]>(
            (a,b) -> a[2] - b[2]
        );
        boolean[][] visited = new boolean[heightMap.length][heightMap[0].length];
        //add eadge
        for (int i = 0; i < heightMap.length; i++) {
            pq.offer(new int[]{i, 0, heightMap[i][0]});
            visited[i][0] = true;
        }
        
        for (int i = 0; i < heightMap.length; i++) {
            pq.offer(new int[]{i, heightMap[0].length-1, heightMap[i][heightMap[0].length-1]});
            visited[i][heightMap[0].length-1] = true;
        }

        
        for(int j = 1; j < heightMap[0].length - 1; j++) {
            pq.offer(new int[]{0, j, heightMap[0][j]});
            visited[0][j] = true;
        }
        
        for (int j = 1; j < heightMap[0].length - 1; j++) {
            pq.offer new int[]{heightMap.length - 1, j, heightMap[heightMap.length - 1][j]});
            visited[heightMap.length -1][j] = true;
        }        
        
        int sum = 0;
        
        while(!pq.isEmpty()) {
            int[] cur = pq.poll();
            
            // explore point around
            for (int i = 0 ; i < 4; i++) {
                if (cur[0] + dx[i] <= 0 || cur[0] + dx[i] >= heightMap.length
                    || cur[1] + dy[i] <= 0 || cur[1] + dy[i] >= heightMap[0].length
                    || visited[cur[0] + dx[i]][cur[1] + dy[i]]) {
                    continue;   
                }
                
                visited[cur[0] + dx[i]][cur[1] + dy[i]] = true;
                
                int nextHeight = heightMap[cur[0] + dx[i]][cur[1] + dy[i]];
                
                if (nextHeight >= cur[2]) {
                    pq.offer(new int[]{cur[0] + dx[i], cur[1] + dy[i], nextHeight});    
                } else {
                   // System.out.println((cur[0] + dx[i]) + " " + (cur[1] + dy[i]) + " " + nextHeight + " " + cur[2]);
                    sum += cur[2] - nextHeight;
                    pq.offer(new int[]{cur[0] + dx[i], cur[1] + dy[i], cur[2]});
                }
                
            }
        }
        return sum;
    }
}
```
