---
title: 1057 Campus Bikes
date: 2019-08-10 03:45:51
categories: LeetCode
tags:
---

```java
class Solution {
    public int[] assignBikes(int[][] workers, int[][] bikes) {
        int n = workers.length;
        
        PriorityQueue<int[]> q = new PriorityQueue<int[]>((a,b) -> {
            int comp = Integer.compare(a[0], b[0]);    
            if (comp == 0) {
                if (a[1] == b[1]) {
                    return Integer.compare(a[2], b[2]);
                }
                
                return Integer.compare(a[1], b[1]);
            }
            return comp;
        });
        
        for (int i = 0; i < workers.length; i++) {
            int[] worker = workers[i];
            
            for (int j = 0; j < bikes.length; j++) {
                int[] bike = bikes[j];
                int distance = Math.abs(worker[0] - bike[0]) + 
                               Math.abs(worker[1] - bike[1]);
                
                q.add(new int[]{distance, i, j});
                
            }
        }
        
        int[] res = new int[n];
        Arrays.fill(res, -1);
        
        Set<Integer> bikeVisited = new HashSet<Integer>();
        
        while( !q.isEmpty()) {            
            int[] tuple = q.poll();
            if (res[tuple[1]] == -1 && !bikeVisited.contains(tuple[2]))
            {
              res[tuple[1]] = tuple[2];
              bikeVisited.add(tuple[2]);
            }
         
        }
        return res;        
        
    }
}
```
