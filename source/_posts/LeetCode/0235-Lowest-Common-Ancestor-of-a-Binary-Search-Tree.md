---
title: 0235 Lowest Common Ancestor of a Binary Search Tree
date: 2018-02-13 22:01:30
categories: LeetCode
tags:
---

Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”

```text
        _______6______
       /              \
    ___2__          ___8__
   /      \        /      \
   0      _4       7       9
         /  \
         3   5
```
For example, the lowest common ancestor (LCA) of nodes 2 and 8 is 6. Another example is LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.


这题求BST的最近公共祖先.

这题是求BST的最近祖先，而不是二叉树。
https://yidongzhang.gitbooks.io/-oa-1/content/bstti.html

```java
public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
  if (p == root || q == root) return root;
  if (Math.min(p.val, q.val) < root.val && root.val < Math.max(p.val, q.val))
     return root;
  if (p.val < root.val) {
     return lowestCommonAncestor(root.left, p, q);
  } else {
     return lowestCommonAncestor(root.right, p, q);
  }
}
```
