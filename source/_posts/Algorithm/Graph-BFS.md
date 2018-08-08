---
title: Graph-BFS
date: 2018-08-07 23:52:42
categories: Algorithm
tags:
---

今天讲图的BFS（广度优先遍历）. 可以以树的BFS作为参考。

在二叉树中:

```txt
      1
     / \
    2   3
   / \ / \
  4  5 6  7
```

BSF 的顺序是 
1,2,3,4,5,6,7, 一层一层，从左往右.

[LeetCode 102](https://leetcode.com/problems/binary-tree-level-order-traversal/description/)

解法1
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def levelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        result = []
        if not root:
            return result
        queue = []
        queue.append(root)
        while queue:
            size = len(queue)
            one_level_result = []
            for i in range(size):
                node = queue.pop(0)
                one_level_result.append(node.val)
                if node.left is not None:
                    queue.append(node.left)
                if node.right is not None:
                    queue.append(node.right)
                
            result.append(one_level_result)
                
        return result
```

另外一种常见的tree 的 bfs 写法
解法2:

```python
class Solution:
    def levelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        result = []
        if not root:
            return result
        queue = []
        queue.append(root)
        while queue:
            
            one_level_result = []
            
            node = queue.pop(0)
            one_level_result.append(node.val)
            if node.left is not None:
                queue.append(node.left)
            if node.right is not None:
                queue.append(node.right)
                
            result.append(one_level_result)
                
        return result
```

这种写法的输出没有层次的关系。你无法判断某个节点在哪一层。



|解法1|解法2|
|:----|:----|
|[[3],[9,20],[15,7]]| [[3],[9],[20],[15],[7]]|

自己对着代码走一遍，为什么?


现在来看图的BFS, 这里假设只有一个连通分量.

```txt
     1---2
    /   /
   0---3---5
    \   \ /
     4---6

```

假设从1 这个点出发:
BFS 的输出结果可以是 0,    1,3,4,    2,5,6
也可以是 0,    4,3,1,    6,5,2
也可以是 0,    4,3,1,    6,2,5

现在以0,    1,3,4,  2,  5,6 为例子
使用队列: 先进先出

|操作              | 队列情况 |  
|:-----------------|:---------|
|0 入队            |  [0]     |
|0 出队，1,3,4 入队| [1,3,4]  |
|1 出队，2 入队    | [3,4,2]  |
|3 出队，5，6入队  | [4,2,5,6]|
|4 出队            | [2,5,6]  |
|2 出队            |  [5,6]   |
|5 出队            |  [6]     |
|6 出队            |  []      |

还记得这种存图的方式吧

```python
def dfs():
        graph = [[1,3,4], [0,2], [1,3], [0,5,6],[0,6],[3,6], [3,4,5]]
        queue = []
        visited = [False] * len(graph)
        queue.append(0)
        
        while queue:
            size = len(queue)
            for i in range(size):
                node_index = queue.pop(0)
                visited[node_index] = True
                print(node_index, end="")
                for value in graph[node_index]:
                    if visited[value] is False:
                        visited[value] = True
                        queue.append(value)
            print("\n")
```
想想问什么graph 的 DFS 需要 visited 数组



额外思考: DFS 和 BFS 的比较

http://rapheal.iteye.com/blog/1526863
