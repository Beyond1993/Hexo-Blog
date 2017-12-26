---
title: Minimum Spanning Tree
date: 2017-12-26 05:45:59
categories: Algorithm
tags:
---

## 最小生成树
刚好趁着做亚马逊OA的机会总结下Minimum Spanning Tree
这篇博客写的很好。 http://www.cnblogs.com/biyeymyhjob/archive/2012/07/30/2615542.html

Prim
Prim 算法关注的是点，找到一个点，再找到其邻接边的最小边，连上。加上访问标记，DFS到下一点。

Kruskar 算法关注的是边，每次都找全局最小的边。发现这条边的两个端点同时属于一个联
通区域，就不需要了。
Kruskar 常常用 Union Find 来实现。

代码如下:
```java
import java.util.*;
class Connection{
    String node1;
    String node2;
    int cost;
    public Connection(String a, String b, int c){
        node1 = a;
        node2 = b;
        cost = c;
    }
}
public class MinimumSpanningTree {
    static class DisjointSet
    {
        Set<String> set;
        Map<String, String> map;
        int count;
        public DisjointSet()
        {
            count = 0;
            set = new HashSet<>();
            map = new HashMap<>();
        }
        public void MakeSet(String s)
        {
            if(!set.contains(s))
            {
                count++;
                set.add(s);
                map.put(s, s);
            }
        }
        public String Find(String s)
        {
            if(!set.contains(s)) return null;
            if(s.equals(map.get(s))) return s;
            String root = this.Find(map.get(s));
            map.put(s, root);
            return root;
        }
        public void Union(String s, String t)
        {
            if(!set.contains(s) || !set.contains(t)) return;
            if(s.equals(t)) return;
            count--;
            map.put(s, t);
        }
    }
    static class ConnectionComparator1 implements Comparator<Connection>
    {
        @Override
        public int compare(Connection a, Connection b)
        {
            return a.cost - b.cost;
        }
    }
    // 按字典树输出
    static class ConnectionComparator2 implements Comparator<Connection>
    {
        @Override
        public int compare(Connection a, Connection b)
        {
            if(a.node1.equals(b.node1)) return a.node2.compareTo(b.node2);
            else return a.node1.compareTo(b.node1);
        }
    }
    public List<Connection> getLowCost(List<Connection> connections)
    {
        Comparator<Connection> comparator1 = new ConnectionComparator1();
        Comparator<Connection> comparator2 = new ConnectionComparator2();
        Collections.sort(connections, comparator1);
        DisjointSet set = new DisjointSet();
        List<Connection> res = new ArrayList<>();
        for(Connection itr: connections)
        {
            set.MakeSet(itr.node1);
            set.MakeSet(itr.node2);
        }
        for(Connection itr: connections)
        {
            String s = set.Find(itr.node1);
            String t = set.Find(itr.node2);
            if(!s.equals(t))
            {
                set.Union(s, t);
                res.add(itr);
                if(set.count == 1) break;
            }
        }
        if(set.count == 1)
        {
            Collections.sort(res, comparator2);
            return res;
        }
        else return new ArrayList<Connection>();
    }
 
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        /*ArrayList<Connection> connections = new ArrayList<>();
//      connections.add(new Connection("Acity","Bcity",1));
//      connections.add(new Connection("Acity","Ccity",2));
//      connections.add(new Connection("Bcity","Ccity",3));
        connections.add(new Connection("A","B",6));
        connections.add(new Connection("B","C",4));
        connections.add(new Connection("C","D",5));
        connections.add(new Connection("D","E",8));
        connections.add(new Connection("E","F",1));
        connections.add(new Connection("B","F",10));
        connections.add(new Connection("E","C",9));
        connections.add(new Connection("F","C",7));
        connections.add(new Connection("B","E",3));
        connections.add(new Connection("A","F",1));
 
        List<Connection> res = getMST(connections);
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " cost : " + c.cost);
        }*/
        MinimumSpanningTree solution = new MinimumSpanningTree();
        
        // test case 1
        /*    A----1-----B
              |        / |
              |      /   |
              6    2     3
              |  /       |
        D--5--E-----7----C
          
       minimum spanning tree
               A---1-----B
                       / |
                     /   |
                   2     3
                 /       |
         D--5--E         C
               
        */
        List<Connection> connections = new ArrayList<>();
        connections.add(new Connection("A", "B", 1));
        connections.add(new Connection("B", "C", 3));
        connections.add(new Connection("B", "E", 2));
        connections.add(new Connection("C", "E", 7));
        connections.add(new Connection("E", "A", 6));
        connections.add(new Connection("D", "E", 5));
        List<Connection> res = solution.getLowCost(connections);
        System.out.println("test case 1: ");
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " " + c.cost);
        }
        
        // test case 2
        connections = new ArrayList<>();
        connections.add(new Connection("A", "B", 2));
        connections.add(new Connection("B", "C", 2));
        connections.add(new Connection("B", "D", 2));
        connections.add(new Connection("C", "D", 2));
        connections.add(new Connection("D", "A", 2));
        connections.add(new Connection("A", "C", 2));
        res = solution.getLowCost(connections);
        System.out.println("test case 2: ");
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " " + c.cost);
        }
        
        // test case 3
        connections = new ArrayList<>();
        connections.add(new Connection("A", "B", 2));
        connections.add(new Connection("B", "C", 2));
        connections.add(new Connection("C", "D", 2));
        connections.add(new Connection("D", "E", 2));
        connections.add(new Connection("E", "F", 2));
        connections.add(new Connection("G", "F", 1));
        connections.add(new Connection("G", "E", 1));
        connections.add(new Connection("G", "E", 1));
        connections.add(new Connection("G", "D", 1));
        connections.add(new Connection("G", "C", 1));
        connections.add(new Connection("G", "B", 1));
        connections.add(new Connection("G", "A", 1));
        connections.add(new Connection("A", "F", 2));
        res = solution.getLowCost(connections);
        System.out.println("test case 3: ");
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " " + c.cost);
        }
        
        // test case 4
        res = solution.getLowCost(null);
        if(res == null) {
            System.out.println("test case 4 correct!");
        } else {
            System.out.println("test case 4 fail!");
        }
        
        // test case 5
        res = solution.getLowCost(new ArrayList<Connection>());
        if(res == null) {
            System.out.println("test case 5 correct!");
        } else {
            System.out.println("test case 5 fail!");
        }
        
        // test case 6
        connections = new ArrayList<>();
        connections.add(new Connection("A", "B", 1));
        connections.add(new Connection("A", "C", 9));
        connections.add(new Connection("A", "D", 4));
        connections.add(new Connection("A", "E", 6));
        connections.add(new Connection("B", "C", 1));
        connections.add(new Connection("B", "D", 2));
        connections.add(new Connection("B", "E", 8));
        connections.add(new Connection("C", "D", 5));
        connections.add(new Connection("D", "C", 7));
        connections.add(new Connection("C", "E", 2));
        connections.add(new Connection("D", "E", 3));
        connections.add(new Connection("D", "F", 97));
        res = solution.getLowCost(connections);
        System.out.println("test case 6: ");
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " " + c.cost);
        }
        
        // test case 7
        connections = new ArrayList<>();
        connections.add(new Connection("A", "B", 1));
        connections.add(new Connection("A", "C", 2));
        connections.add(new Connection("C", "B", 7));
        connections.add(new Connection("D", "E", 1));
        connections.add(new Connection("F", "E", 8));
        res = solution.getLowCost(connections);
        if(res == null) {
            System.out.println("test case 7 correct!");
        } else {
            System.out.println("test case 7 fail!");
        }
        // test case 8
        connections = new ArrayList<>();
        connections.add(new Connection("C", "E", 1));
        connections.add(new Connection("F", "B", 2));
        connections.add(new Connection("C", "A", 3));
        connections.add(new Connection("C", "D", 4));
        connections.add(new Connection("D", "E", 5));
        connections.add(new Connection("G", "E", 6));
        connections.add(new Connection("D" ,"I", 7));
        connections.add(new Connection("I" ,"E", 8));
        connections.add(new Connection("A", "K", 9));
        connections.add(new Connection("A", "B", 10));
        connections.add(new Connection("A", "H", 11));
        connections.add(new Connection("K", "J", 12));
        connections.add(new Connection("I", "G", 13));
        connections.add(new Connection("F", "G", 14));
        connections.add(new Connection("A", "J", 15));
        connections.add(new Connection("J", "B", 16));
        connections.add(new Connection("E", "H", 17));
        res = solution.getLowCost(connections);
        System.out.println("test case 8: ");
        for (Connection c : res){
            System.out.println(c.node1 + " -> " + c.node2 + " " + c.cost);
        }                                                                                                                                                                                                                                                  } 
}
```

