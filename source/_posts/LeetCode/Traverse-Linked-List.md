---
title: Traverse Liked List
date: 2019-08-24 19:40:19
categories: LeetCode
tags:
---

Input:

```txt

1---2---3---4---5---6---NULL
        |
        7---8---9---10--NULL
            |
           11---12---NULL
```

output:

```txt
1-2-3-7-8-11-12-9-10-4-5-6
```

转成 tree 的形式


```txt 
            1
           /
          2
         /
        3
       / \
      4    7
      /   / 
     5   8  
     /  / \
    6  9  11
      /    \
     10    12
```
        
```java
class Solution {
    public void printTree(TreeNode root) {
        TreeNode node1 = new TreeNode(1);
        TreeNode node2 = new TreeNode(2);
        TreeNode node3 = new TreeNode(3);
        TreeNode node4 = new TreeNode(4);
        TreeNode node5 = new TreeNode(5);
        TreeNode node6 = new TreeNode(6);
        TreeNode node7 = new TreeNode(7);
        TreeNode node8 = new TreeNode(8);
        TreeNode node9 = new TreeNode(9);
        TreeNode node10 = new TreeNode(10);
        TreeNode node11 = new TreeNode(11);
        TreeNode node12 = new TreeNode(12);
        node1.left = node2;
        node2.left = node3;
        node3.left = node4;
        node4.left = node5;
        node5.left = node6;
        node3.right = node7;
        node7.left = node8;
        node8.left = node9;
        node9.left = node10;
        node8.right = node11;
        node11.right = node12;
        dfs(node1);
        return new ArrayList<Integer>();
    }
    
    public void dfs(TreeNode root) {
        if (root == null) {
            return;
        }
        System.out.println(root.val);
        dfs(root.right);
        dfs(root.left);
    }
}
```


