---
title: Dijkstra
date: 2018-02-06 07:56:41
categories: Algorithm
tags:
---

Dijkstra 算法

单源最短路径, 如果用负权重的话，很可能没有最短路径的.

1. 最简单的方法

就是用bfs, 不断搜索，每出队一个节点， 就更新邻居。比当前值小，就更新.

时间复杂度是 O(V^2), 因为最坏情况是一个完全图.

2. 二叉堆 （就是一般意义的堆)


用 priority queue 的好处不是heap pop 出来的一定是当前最小的.

而是有些路径根本不用去遍历。相当于一个剪枝的过程.


```text
        +--- node2 ---+
      1                2
     /                  \
node1 ---5---node3 --1-- node5
    \                    / 
      3                 1
       \ ----node4--1--/
```


如果用 pq的话， node2 出堆之后，就是node5 出堆, 然后紧接着把 node3 的distance 变成 4，这样就不会用 node1 --5-- node3 这条边去尝试了.
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
     
     visited.put(node.getValue(), node.getWeight()); // zhe li bu dui ba
     
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
