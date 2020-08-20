---
title: 0323 Number of Connected Components in an Undirected Graph
date: 2017-12-26 06:21:06
categories: LeetCode
tags:
---

```java
class Solution {
    public int countComponents(int n, int[][] edges) {
        UF uf = new UF(n);
        for (int[] pair:edges) {
            int x = pair[0];
            int y = pair[1];
            uf.union(x,y);
        }
        return uf.count;
 }
 class UF {
    int count;
    private int[] parent, rank;
    private UF(int n) {
       count = n;
       parent = new int[n];
       for (int i=0;i<n;i++) {
           parent[i] = i;
       }
    }
    private void union(int i, int j) {
        int a = find(i);
        int b = find(j);
        if (a==b) {
            return;
        }
        parent[a] = b;
        count--;
    }
    private  int find(int i) {
        if (i==parent[i]) {
            return i;
        }
        return parent[i] = find(parent[i]);
    } 
    }
}
```
