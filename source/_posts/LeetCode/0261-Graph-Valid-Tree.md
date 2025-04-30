---
title: 0261 Graph Valid Tree
date: 2017-12-26 06:18:00
categories: LeetCode
tags:
---

🌳 一棵有效的树，要满足两个条件：
1. 连通性：所有节点都在一个连通图中；

2. 无环性：图中不能有环。

Union Find
```java
public class Solution {
    class UnionFind {
    int[] father;
    Set<Integer> set;
    UnionFind(int n) {
        father = new int[n];
        set = new  HashSet<Integer>();
        for (int i = 0; i < n; i++) {
            father[i] = i;
        }
    }
    
    private int find(int x) {
        if (father[x] == x) {
            return x;
        }
        
        return father[x] = find(father[x]);
    }
    
    public boolean connect(int a, int b) {
        int father_a = find(a);
        int father_b = find(b);
        
        if (father_a == father_b) {
            set.add(father_a);
            return true;
        } else {
            father[father_b] = father_a;
            set.remove(father_b);
            set.add(father_a);
            return false;
        }
    }
    
    public boolean isValid() {
        if (set.size() > 1) {
            return false;
        }
        Integer root = set.iterator().next();
        for (int i = 0 ; i < father.length; i++) {  
            if (find(i) != root) {
                return false;
            }
        }
        return true;
    }
}
public boolean validTree(int n, int[][] edges) {
    if (edges.length == 0) {
        return n > 1? false:true;
    }
    UnionFind uf = new UnionFind(n);
    for (int i = 0; i < edges.length; i++) {
        int start = edges[i][0];
        int end = edges[i][1];

        if (uf.connect(start, end)) {
            return false;
        }
    }
    return uf.isValid();
}
}
```

BFS 
```java
class Solution {
    public boolean validTree(int n, int[][] edges) {
         if(n-1 != edges.length) {
            return false;
        }
        Map<Integer, Set<Integer>> graph = initializeGraph(n,edges);

        //bfs
        Queue<Integer> q = new LinkedList<>();
        Set<Integer> hash = new HashSet<>();

        q.offer(0);
        hash.add(0);

        while (!q.isEmpty()) {
            int node = q.poll();
            for (Integer neighbor: graph.get(node)) {
                if (hash.contains(neighbor)) {
                    continue;
                }
                hash.add(neighbor);
                q.offer(neighbor);
            }
        }
        return (hash.size() == n);
        
    }
    private Map<Integer, Set<Integer>> initializeGraph(int n, int[][] edges) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        for (int i=0;i<n;i++) {
            graph.put(i,new HashSet<Integer>());
        }
        for (int i=0;i<edges.length;i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }
        return graph;
    }
}
```

DFS
```java
public class Solution {

  public boolean validTree(int n, int[][] edges) {
        // build the graph using adjacent list
        List<Set<Integer>> graph = new ArrayList<Set<Integer>>();
        for(int i = 0; i < n; i++)
            graph.add(new HashSet<Integer>());
        for(int[] edge : edges)
        {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }
        
        // no cycle
        boolean[] visited = new boolean[n];
        Deque<Integer> stack = new ArrayDeque<Integer>();
        stack.push(0);
        while(!stack.isEmpty())
        {
            int node = stack.pop();
            if(visited[node])
                return false;
            visited[node] = true;
            for(int neighbor : graph.get(node))
            {
                stack.push(neighbor);
                graph.get(neighbor).remove(node);
            }
        }
        
        // fully connected
        for(boolean result : visited)
        {
            if(!result)
                return false;
        }
        
        return true;
    }
 
}
```

