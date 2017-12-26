---
title: 0133 Clone Graph
date: 2017-12-26 05:03:20
categories: LeetCode
tags:
---

Clone an undirected graph. Each node in the graph contains a label and a list of its neighbors.


OJ's undirected graph serialization:
Nodes are labeled uniquely.

We use # as a separator for each node, and , as a separator for node label and each neighbor of the node.
As an example, consider the serialized graph {0,1,2#1,2#2,2}.

The graph has a total of three nodes, and therefore contains three parts as separated by #.

First node is labeled as 0. Connect node 0 to both nodes 1 and 2.
Second node is labeled as 1. Connect node 1 to node 2.
Third node is labeled as 2. Connect node 2 to node 2 (itself), thus forming a self-cycle.
Visually, the graph looks like the following:

```text
       1
      / \
     /   \
    0 --- 2
         / \
         \_/
```


这题的DFS BFS 的两种解法都很简单。 但是这题有意思的地方有两点，第一点是 这题图的表示方法

{**0**,1,2#**1**,2#**2**,2}

这正是ACM 中常用的[前向星](http://www.wayne.ink/2017/12/26/Algorithm/Graph-Stroage/)


还有一点，为什么一定要用Map? 不用map 行不行。

我们一开始就设置好了newNode, 在原始的图中遍历出来一个node, 我怎么把这个node 对应的 newnode 加到新的图中？

所以我们用了Map, 用map的根本原因就是利用Node.Label为桥梁，找到新图对应的点。把新生成的节点加进去。

而且 Hashmap里有重复的值，就不需要再加到队列里了

**所以使用 Map 也是克隆题的必备条件** 比如 [138 Copy List with Random Pointer](http://www.wayne.ink/2017/12/26/LeetCode/0138-Copy-List-with-Random-Pointer/)
BFS
```java
/**
 * Definition for undirected graph.
 * class UndirectedGraphNode {
 *     int label;
 *     List<UndirectedGraphNode> neighbors;
 *     UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 * };
 */
public class Solution {
    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        if (node == null) return null;
        UndirectedGraphNode newNode = new UndirectedGraphNode(node.label);
        Map<Integer, UndirectedGraphNode> map = new HashMap<Integer, UndirectedGraphNode>();
        Queue<UndirectedGraphNode> queue = new LinkedList<UndirectedGraphNode>();
        map.put(newNode.label, newNode);
        queue.add(node);
        while(!queue.isEmpty()) {
            UndirectedGraphNode cur = queue.poll();
            for (int i = 0; i < cur.neighbors.size(); i++) {
                if (!map.containsKey(cur.neighbors.get(i).label)) {
                    map.put(cur.neighbors.get(i).label, new UndirectedGraphNode(cur.neighbors.get(i).label));
                    queue.add(cur.neighbors.get(i));
                    //find the current node in new Map
                    map.get(cur.label).neighbors.add(map.get(cur.neighbors.get(i).label));
                } else {
                    map.get(cur.label).neighbors.add(map.get(cur.neighbors.get(i).label));
                }
            }
        }
        return newNode;
    }
}
```

DFS
```java
public class Solution {
    private HashMap<Integer, UndirectedGraphNode> map = new HashMap<>();
    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        return clone(node);
    }

    private UndirectedGraphNode clone(UndirectedGraphNode node) {
        if (node == null) return null;
        
        if (map.containsKey(node.label)) {
            return map.get(node.label);
        }
        UndirectedGraphNode clone = new UndirectedGraphNode(node.label);
        map.put(clone.label, clone);
        for (UndirectedGraphNode neighbor : node.neighbors) {
            clone.neighbors.add(clone(neighbor));
        }
        return clone;
    }
}
```





