---
title: 1519 Number of Nodes in the Sub-Tree With the Same Label
date: 2020-07-19 23:11:03
categories: LeetCode
tags:
---

超时版本
```java
class Solution {
    public int[] countSubTrees(int n, int[][] edges, String labels) {
        
        Map<Integer, Set<Integer>> tree = new HashMap<>();
        Map<Integer, Set<Integer>>  connection = new HashMap<>();
        Map<Integer, Integer>  f = new HashMap<>();
        
        for (int i = 0; i < n; i++) {
            tree.put(i, new HashSet<>());
            connection.put(i, new HashSet<>());
        }
        
        for (int i = 0; i < edges.length; i++) {
            connection.get(edges[i][0]).add(edges[i][1]);
            connection.get(edges[i][1]).add(edges[i][0]);
        }
        
        Queue<Integer> q1 = new LinkedList<>();
        
        q1.offer(0);
        int[] visited = new int[n];
        visited[0] = 1;
        
        while(!q1.isEmpty()) {
            int num = q1.poll();
           
            for (int v : connection.get(num)) {
                 if (visited[v] == 1) continue;
                 visited[v] = 1;
                 tree.get(num).add(v);
                 f.put(v, num);
                 q1.offer(v);
            }
        }
        
        Queue<Integer> q = new LinkedList<>();
        
        for (int i = 0; i < n; i++) {
            if (tree.get(i).isEmpty()) {
                q.offer(i);
            }
        }
        
        while(!q.isEmpty()) {
            int size = q.size();
            
            for (int i = 0; i< size; i++) {
                int v = q.poll();
                if (!f.containsKey(v)) continue;
                int father = f.get(v);
                tree.get(father).addAll(tree.get(v));
                q.offer(father);
            }
        }
        
        
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            int count = 0;
           
            for (int v : tree.get(i)) {
                if (labels.charAt(i) == labels.charAt(v)) {
                    count++;
                }
            }
            res[i] = count + 1;
        }
        return res;
    }
    
}
```
