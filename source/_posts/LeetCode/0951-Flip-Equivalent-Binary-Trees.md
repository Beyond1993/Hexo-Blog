---
title: 0951 Flip Equivalent Binary Trees
date: 2020-05-25 00:46:19
categories: LeetCode
tags:
---

For a binary tree T, we can define a flip operation as follows: choose any node, and swap the left and right child subtrees.

A binary tree X is flip equivalent to a binary tree Y if and only if we can make X equal to Y after some number of flip operations.

Write a function that determines whether two binary trees are flip equivalent.  The trees are given by root nodes root1 and root2.

 

Example 1:

Input: root1 = [1,2,3,4,5,6,null,null,null,7,8], root2 = [1,3,2,null,6,4,5,null,null,null,null,8,7]
Output: true
Explanation: We flipped at nodes with values 1, 3, and 5.

![](https://assets.leetcode.com/uploads/2018/11/29/tree_ex.png)


中文题意: 能否通过左右子树的旋转 把左边的二叉树变成右边的二叉树？

只要同一个节点的左右子树的数值一样就可以了。可以tree1 的左子树等于 tree2的左子树，也可以等于tree2的右子树.

所以有两种情况:

case1: r1.left == r2.left && r1.right == r2.right
case2: r1.left == r2.right && r1.right == r2.left

两种情况只要满足一种就可以了

### DFS
```java
class Solution {
    public boolean flipEquiv(TreeNode r1, TreeNode r2) {
        if (r1 == null || r2 == null) return r1 == r2;
        return r1.val == r2.val &&
               (flipEquiv(r1.left, r2.left) && flipEquiv(r1.right, r2.right) || 
               flipEquiv(r1.left, r2.right) && flipEquiv(r1.right, r2.left));
    }
}
```

### BFS
```java
class Solution {
    public boolean flipEquiv(TreeNode r1, TreeNode r2) {
        Queue<TreeNode> q1 = new LinkedList<>();
        Queue<TreeNode> q2 = new LinkedList<>();
        q1.offer(r1);
        q2.offer(r2);
        
        while (!q1.isEmpty() && !q2.isEmpty()) {
            TreeNode node1 = q1.poll();
            TreeNode node2 = q2.poll();
            
            if (node1 == null || node2 == null || node1.val != node2.val) {
                if (node1 == node2) continue;
                return false;
            }
            
            if (node1.left == node2.left || 
                (node1.left != null && node2.left != null && node1.left.val == node2.left.val) ) {
                q1.addAll(Arrays.asList(node1.left, node1.right));
            } else {
                q1.addAll(Arrays.asList(node1.right, node1.left));
            }
            q2.addAll(Arrays.asList(node2.left, node2.right));
        }
        return q1.isEmpty() && q2.isEmpty();
    }
}
```
