---
title: 0236 Lowest Common Ancestor of a Binary Tree
date: 2018-02-13 01:17:33
categories: LeetCode
tags:
---

```java
public class Solution {
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
}
```

这题不能剪枝
