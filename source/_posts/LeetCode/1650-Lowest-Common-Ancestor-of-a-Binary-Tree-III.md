---
title: 1650-Lowest-Common-Ancestor-of-a-Binary-Tree-III
date: 2023-12-23 03:24:09
categories: LeetCode
tags:
---

Given two nodes of a binary tree p and q, return their lowest common ancestor (LCA).

Each node will have a reference to its parent node. The definition for Node is below:

```java
class Node {
    public int val;
    public Node left;
    public Node right;
    public Node parent;
}
```

According to the definition of LCA on Wikipedia: "The lowest common ancestor of two nodes p and q in a tree T is the lowest node that has both p and q as descendants (where we allow a node to be a descendant of itself)."


```java
/*
// Definition for a Node.
class Node {
    public int val;
    public Node left;
    public Node right;
    public Node parent;
};
*/

class Solution {
    public Node lowestCommonAncestor(Node p, Node q) {
        Set<Node> parents = new HashSet<>();
        Queue<Node> queue = new LinkedList<>();
        queue.offer(p);
        queue.offer(q);
        while(!queue.isEmpty()) {
            Node cur = queue.poll();
            if (parents.contains(cur)) return cur;
            parents.add(cur);
            if (cur.parent != null) {
                queue.add(cur.parent);
            }
        }
        return null;
    }
}

```

Python

```python
class Solution:
    def lowestCommonAncestor(self, p: 'Node', q: 'Node') -> 'Node':
        parent = set()
        queue = [p, q]

        while queue:
            cur = queue.pop(0)
            if cur in parent: ## 如果cur 节点已经出现两次，说明是共同祖先
                return cur
            
            parent.add(cur)

            if cur.parent is not None:
                queue.append(cur.parent)
        return None
```

