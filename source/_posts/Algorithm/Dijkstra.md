---
title: Dijkstra
date: 2018-02-06 07:56:41
categories: Algorithm
tags:
---

Dijkstra 算法

单源最短路径, 如果用负权重的话，很可能没有最短路径的.

### 1. 最简单的方法

就是用bfs, 不断搜索，每出队一个节点， 就更新邻居。比当前值小，就更新.

时间复杂度是 O(V^2), 因为最坏情况是一个完全图.

### 2. 二叉堆 （就是一般意义的堆)


用 priority queue 的好处

**不是heap pop 出来的一定是当前最小的.***

而是有些路径根本不用去遍历。相当于一个剪枝的过程.


```text
        +--- node2 ---+
      1                2
     /                  \
node1 ---5---node3 --1-- node5
    \                    / 
      3                 1
       \ ----node4-----/
```


如果用 pq的话， node2 出堆之后，就是node5 出堆, 然后紧接着把 node3 的distance 变成 4，这样就不会用 node1 --5-- node3 这条边去尝试node5 了.
这种的时间复杂度是 E  + VlogV

http://www.cnblogs.com/dzkang2011/p/3828965.html
https://codereview.stackexchange.com/questions/67704/optimizing-dijkstra-implementation-using-priorityqueue-in-java

在具体代码实现的时候， 对于这种情况.
```text

A ---- 5 ---- B ------3-----D
 \           /
  2         2
   \----C--/
```

当A出pq的时候，B, C 进入pq , 接着C出 pq 的时候，B 怎么处理？?

就是在poririty queue 里的值怎么更新的问题。

有两种思路

思路1: 利用另外辅助的数据结构，维护Minimum distance. 比如 Map, Distance[][], 这样子priority queue 里会有很多冗余节点，可能对 priority queue 操作的时间复杂度 log(v*v) ==> 2logv. 当pq 里的某个节点 要更新成最小节点时，因为这个节点不一定在堆顶, 直接加入新的重复节点

先来看看 505 The Maze II 的 Dijsktra 解法. 就是用一个全局的distance[][] 来记录当前的位置.
这就是一个很常规的解法。要先判断。distance[s[0][s[1]] + count < distance[x - dir[0][y - dir[1]]

if (distance[s[0]][s[1]] + count < distance[x - dir[0]][y - dir[1]]) {
      distance[x - dir[0]][y - dir[1]] = distance[s[0]][s[1]] + count;
      queue.offer(new int[]{x - dir[0], y - dir[1], distance[x - dir[0]][y - dir[1]]});
    }

```java
public class Solution {
    public int shortestDistance(int[][] maze, int[] start, int[] dest) {
        int[][] distance = new int[maze.length][maze[0].length];
        for (int[] row: distance)
            Arrays.fill(row, Integer.MAX_VALUE);
        distance[start[0]][start[1]] = 0;
        dijkstra(maze, start, distance);
        return distance[dest[0]][dest[1]] == Integer.MAX_VALUE ? -1 : distance[dest[0]][dest[1]];
    }
    public void dijkstra(int[][] maze, int[] start, int[][] distance) {
        int[][] dirs={{0,1},{0,-1},{-1,0},{1,0}};
        PriorityQueue < int[] > queue = new PriorityQueue < > ((a, b) -> a[2] - b[2]);
        queue.offer(new int[]{start[0],start[1],0});
        while (!queue.isEmpty()) {
            int[] s = queue.poll();
            if(distance[s[0]][s[1]] < s[2])
                continue;
            for (int[] dir: dirs) {
                int x = s[0] + dir[0];
                int y = s[1] + dir[1];
                int count = 0;
                while (x >= 0 && y >= 0 && x < maze.length && y < maze[0].length && maze[x][y] == 0) {
                    x += dir[0];
                    y += dir[1];
                    count++;
                }
                // x - dir[0], y - dir[1] 意味着退了一步
                if (distance[s[0]][s[1]] + count < distance[x - dir[0]][y - dir[1]]) {
                    distance[x - dir[0]][y - dir[1]] = distance[s[0]][s[1]] + count;
                    queue.offer(new int[]{x - dir[0], y - dir[1], distance[x - dir[0]][y - dir[1]]});
                }
            }
        }
    }
}
```

@智慧哥 多谢智慧哥提供里一个 HashMap 的解法.十分巧妙
这里的HashMap 有两个作用，一是存储当前点到 start 点的距离， 二是只要是从priority queue 里拿出来的点就已经是最优解里，只要出现过一次，就是最优解。所以HashMap 里的key 一旦存在，就直接跳过 (据说用反证法)

上面的解法，是从 pq poll 出来的一点的 neighbors 来考虑的, 而这个解法，只着眼于 pq poll 出来的那点是不是已经在hashMap 里，neighbors 只是无脑放进堆.

```java
// Your last Java code is saved below:
// package whatever; // don't place package name!
// #       --2 -b ------\
// #     /               1
// #    a -- 6-- c -- 2 - e
// #      \              
// #       4-- d --10---/

import java.io.*;
import java.util.*;
class MyCode {
  static class Node{
    Character val; 
    Integer weight; 
    public Node(Character val, Integer weight){
        this.val = val;
        this.weight = weight;
    }
    public Character getValue(){
        return val;
    } 
    public Integer getWeight(){
        return weight;
    } 
   };
  
  public static Map<Character, Integer> Dijsktra(Map<Character, List<Node>> graph, Character start) {
   
   //initial result
   Map<Character, Integer> visited = new HashMap<>();
   PriorityQueue<Node> pq = new PriorityQueue<Node>(1,(a,b)->(a.weight - b.weight));
   Node tempNode = new Node('a',0);
   pq.offer(tempNode);
                 
   while(!pq.isEmpty()) {
     Node node = pq.poll();
     if(visited.containsKey(node.getValue())) {
        continue;
     }
     visited.put(node.getValue(), node.getWeight());
     List<Node> neighbors = graph.get(node.getValue());
     for (Node val : neighbors) {
       Node newNode = new Node(val.getValue(), val.weight + node.weight);
       pq.offer(newNode);
     }
   }
   return visited;
 }
  
public static void main (String[] args) {
    Map<Character, List<Node>> map = new HashMap<>();
    
    map.put('a', new ArrayList<Node>());
    map.get('a').add(new Node('b',2));
    map.get('a').add(new Node('c',6));
    map.get('a').add(new Node('d',4));
         
    map.put('b', new ArrayList<Node>());
    map.get('b').add(new Node('a',2));
    map.get('b').add(new Node('e',11));
    
    map.put('c', new ArrayList<Node>());
    map.get('c').add(new Node('a',6));
    map.get('c').add(new Node('e',2));
      
    map.put('d', new ArrayList<Node>());
    map.get('d').add(new Node('e',1)); 
    map.get('d').add(new Node('a',4)); 
            
    map.put('e', new ArrayList<Node>()); 
    map.get('e').add(new Node('b',11));
    map.get('e').add(new Node('c',2));
    map.get('e').add(new Node('d',1));
  
    Map<Character, Integer> dis =  Dijsktra(map, 'a');
  
    for (Map.Entry<Character, Integer> entry : dis.entrySet()) {
      System.out.println(entry.getKey() + " "  + entry.getValue());
    }
  }
}
```


思路2: 直接在数据结构里, 维护当前节点的最小值，数据结构里没有冗余节点. 这样要把数据结构里的 invalid 的节点remove 掉

用 TreeSet 有一个问题, 那就是如果 b,c 到 start 点的距离都是最小的，TreeSet 里只能保存 一个 节点 
这样就可以用 TreeMap<Distance, List<Node>> 来解决这个问题

With TreeSet
```java
import java.util.*;
import java.io.*;

public class Dijkstra {
  static Scanner in = new Scanner(new BufferedReader(new InputStreamReader(
      System.in)));

  public static void main(String[] args) {
    new Dijkstra().solve();
  }

  void solve() {
    int n = in.nextInt(), m = in.nextInt();
    ArrayList<ArrayList<Integer>> g = new ArrayList<ArrayList<Integer>>();
    for (int i = 0; i < n; i++)
      g.add(new ArrayList<Integer>());
    ArrayList<ArrayList<Integer>> e = new ArrayList<ArrayList<Integer>>();
    for (int i = 0; i < n; i++)
      e.add(new ArrayList<Integer>());

    while (m-- > 0) {
      int a = in.nextInt() - 1, b = in.nextInt() - 1, c = in.nextInt();
      g.get(a).add(b);
      e.get(a).add(c);
      g.get(b).add(a);
      e.get(b).add(c);
    }

    final long[] d = new long[n];
    int[] prev = new int[n];
    long INFINITY = (long)2.0e13;
    for (int i = 1; i < n; i++)
      d[i] = INFINITY;

    TreeSet<Integer> q = new TreeSet<Integer>(new Comparator<Integer>() {
      public int compare(Integer a, Integer b) {
        if (d[a] < d[b]) return -1;
        if (d[a] > d[b]) return 1; 
        return a - b;
      }
    });

    // start dijkstra
    q.add(0);
    while (!q.isEmpty()) {
      int u = q.pollFirst();
      for (int i = 0; i < g.get(u).size(); i++) {
        int v = g.get(u).get(i);
        int duv = e.get(u).get(i);
        if (d[v] > d[u] + duv) {
          q.remove(v);
          d[v] = d[u] + duv;
          q.add(v);
          prev[v] = u;
        }
      }
    }
    // end dijkstra

    if (d[n-1] == INFINITY)
      System.out.println(-1);
    else {
      ArrayList<Integer> shortest = new ArrayList<Integer>();
      int ptr = n - 1;
      while (true) {
        shortest.add(ptr);
        if (ptr == 0)
          break;
        ptr = prev[ptr];
      }
      for (int i = shortest.size() - 1; i > 0; i--)
        System.out.print((shortest.get(i) + 1) + " ");
      System.out.println(shortest.get(0) + 1);

    }
  }
}
```

在通信工程领域, 算最短路径，因为有信号衰减的问题，所以 weight 是动态变化的。 
OSPF不厉害，EIGRP厉害





