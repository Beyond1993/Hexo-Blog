---
title: 0787 Cheapest Flights Within K Stops
date: 2019-10-17 03:36:21
categories: LeetCode
tags:
---



```java
class Solution {
    class Node {
        int label;
        int dist;
        int step = 0;
        Node (int l, int d) {
            label = l; dist = d; 
        }
        Node (int l, int d, int s) {
            label = l; dist = d; step = s; 
        }
    }
    
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<Node>> graph = new HashMap<> ();
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<Node>());
        }
        for (int i = 0; i < flights.length; i++) {
            int[] edge = flights[i];
            graph.get(edge[0]).add (new Node (edge[1], edge[2]));
        }
        PriorityQueue<Node> pq = new PriorityQueue<> ((a, b) -> a.dist - b.dist);
        Set<Integer> set = new HashSet<Integer>();
        pq.offer (new Node (src, 0));
        while (!pq.isEmpty ()) {
            Node cur_node = pq.poll ();
            if (cur_node.label == dst)
                return cur_node.dist;
            
            if (set.contains(cur_node.label)) {
                continue;
            }
            
            set.add(cur_node.label);
            
            for (Node neighbor : graph.get (cur_node.label)) {
                int new_step = cur_node.step + 1;
                int new_dist = cur_node.dist + neighbor.dist;
                    if (new_step <= k + 1) { 
                        pq.offer (new Node (neighbor.label, new_dist, new_step));
                    }
                }
        }
        return -1;
    }
}
```

上面这个答案过不了

```txt
4
[[0,1,1],[0,2,5],[1,2,1],[2,3,1]]
0
3
1
      5
   0 -------2
   |   1 /  | 
 1 |   /    | 1
   1        3

```

弹出 0 - 1 边, 1 2 边之后,  节点2 已经访问过了,直接跳过。
这样就把 0-2-3 这个答案忽略了 


```java
class Solution {
    class Node {
        int label;
        int dist;
        int step = 0;
        Node (int l, int d) {
            label = l; dist = d; 
        }
        Node (int l, int d, int s) {
            label = l; dist = d; step = s; 
        }
    }
    
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<Node>> graph = new HashMap<> ();
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<Node>());
        }
        for (int i = 0; i < flights.length; i++) {
            int[] edge = flights[i];
            graph.get(edge[0]).add (new Node (edge[1], edge[2]));
        }
        
        int[][] dist = new int[n][k+2];
         for (int i = 0; i < dist.length; i++) 
             for (int j = 0; j < dist[0].length; j++)
                dist[i][j] = i == src ? 0 : Integer.MAX_VALUE;
        
        PriorityQueue<Node> pq = new PriorityQueue<> ((a, b) -> a.dist - b.dist);
        
        pq.offer (new Node (src, 0));
        while (!pq.isEmpty ()) {
            Node cur_node = pq.poll ();
            if (cur_node.label == dst)
                return cur_node.dist;
            
            for (Node neighbor : graph.get (cur_node.label)) {
                int new_step = cur_node.step + 1;
                int new_dist = cur_node.dist + neighbor.dist;
                    if (new_step <= k + 1 && new_dist < dist[neighbor.label][new_step]) {                       
                        dist[neighbor.label][new_step]= new_dist;
                        pq.offer (new Node (neighbor.label, new_dist, new_step));
                    }
                }
        }
        return -1;
    }
}
```

E + VlogV
