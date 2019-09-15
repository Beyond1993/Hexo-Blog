---
title: 0785 Is Graph Bipartite?
date: 2019-09-15 19:57:21
categories: LeetCode
tags:
---

[[],[3],[],[1],[]]

用 bfs 判断是否为二分图，考虑孤立节点的情况

```java
class Solution {
    public boolean isBipartite(int[][] graph) {  
        int n = graph.length;
        int[] color = new int[n];
        Queue<Integer> q = new LinkedList<>();
        for (int k = 0; k < n ; k++) {
            if (color[k] != 0) {
                continue;
            }
            color[k] = 1;
            q.offer(k);
            while(!q.isEmpty()) {
                int size = q.size();
                for (int i = 0; i < size; i++) {
                    int cur = q.poll();
                    int curColor = color[cur];
                    for (int nei : graph[cur]) {
                        if (color[nei] == curColor) {
                            return false;
                        } if (color[nei] == 0) {
                              color[nei] = -curColor;
                              q.offer(nei);
                        }

                    }
                }
            }
        }
        return true;
    }
}
```
