---
title: 0236 Lowest Common Ancestor of a Binary Tree
date: 2018-02-13 22:11:01
categories: LeetCode
tags:
---

Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”

```text
        _______3______
       /              \
    ___5__          ___1__
   /      \        /      \
   6      _2       0       8
         /  \
         7   4
```

For example, the lowest common ancestor (LCA) of nodes 5 and 1 is 3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

这题求两个节点的最近公共祖先，有两种情况:

case 1: left and right 都分别找到了，那最近公共祖先就是当前节点
case 2: 一个点是另一个点的祖先， 比如 p = 2,q = 4 这题有个隐藏的逻辑，就是 **p, q 肯定在二叉树上**，
这时候如果left 找到，right 没找到，就意味着，另一个没找到的肯定在left 的子树下面，不管这个剩下的节点在哪个位置，
先找到的这个Left 肯定是这两个点的祖先，剩下的那个可以不用找了，直接返回。


```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':

        if not root:
            return root

        def dfs(node):
            if not node:
                return None
            if node == p or node == q:
                return node

            left = dfs(node.left)
            right = dfs(node.right)

            print(left, right)
            if left and right:
                return node
            if left and not right :
                return left
            if right and not left:
                return right

        return dfs(root)
```

与此相对应的是 如果不能保证 p, q 都在树上，则是这题的后续题目，要用到后序遍历 确保每个节点都能访问到。

https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree-ii/description/

```java
public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
    if (root == null || root == p || root == q) {
        return root;
    }
    
    TreeNode left  = lowestCommonAncestor(root.left,  p, q);
    TreeNode right = lowestCommonAncestor(root.right, p ,q);
        
    if (left != null & right != null) {
        return root;
    } 
        
    if (left != null && right == null) {
        return left;
    }
        
    if (right != null && left == null) {
        return right;
    }
    return null;
}
```
