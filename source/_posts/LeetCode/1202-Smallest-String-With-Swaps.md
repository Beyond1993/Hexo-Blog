---
title: 1202 Smallest String Swaps
date: 2019-09-22 04:02:48
categories: LeetCode
tags:
---


```java
class Solution {
    class UnionFind {
      int[] parents;

      UnionFind(int size) {
        this.parents = new int[size];
        for (int i = 0; i < size; i++) {
          this.parents[i] = i;
        }
      }

      void connect(int a, int b) {
        parents[getParent(b)] = getParent(a);
      }

      int getParent(int a) {
        int parent = parents[a];
        if (parent != a) {
          parent = getParent(parent);
          parents[a] = parent;
        }
        return parent;
      }
    }

    public String smallestStringWithSwaps(String s, List<List<Integer>> pairs) {
        if (pairs.isEmpty()) {
            return s;
        }

      int n = s.length();

      UnionFind uf = new UnionFind(n);
        
      for (List<Integer> pair : pairs) {
        uf.connect(pair.get(0), pair.get(1));
      }

      Map<Integer, Queue<Character>> graphs = new HashMap<>();
        
      for(int i = 0; i < n; i++) {
          graphs.put(i, new PriorityQueue<Character>());
      }
     
      
      for (int i = 0; i < n; i++) {
        int parent = uf.getParent(i);
        graphs.get(parent).offer(s.charAt(i));
      }

     
      StringBuilder sb = new StringBuilder();
        
      for (int i = 0; i < n; i++) {
      
          sb.append(graphs.get(uf.getParent(i)).poll());
      }
      return sb.toString();
    }
}
```
