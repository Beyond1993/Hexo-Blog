---
title: 0863 All Nodes Distance K in Binary Tree
date: 2019-09-16 23:29:37
categories: LeetCode
tags:
---

We are given a binary tree (with root node root), a target node, and an integer value K.

Return a list of the values of all nodes that have a distance K from the target node.  The answer can be returned in any order.

 

Example 1:

Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, K = 2

Output: [7,4,1]

Explanation: 
The nodes that are a distance 2 from the target node (with value 5)
have values 7, 4, and 1.

```java

       3
      /   \
     5      1
    / \    / \
   6   2  0  8
      / \
     7   4  
```

Note that the inputs "root" and "target" are actually TreeNodes.
The descriptions of the inputs above are just serializations of these objects.


```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    List<Integer> res = new ArrayList<>();
    Map<TreeNode, TreeNode> parent = new HashMap<>();
    Set<TreeNode> set = new HashSet<>();
    public List<Integer> distanceK(TreeNode root, TreeNode target, int K) {
        dfs(root, null);
        searchK(target, K);
        return res;    
    }
    
    private void dfs(TreeNode root, TreeNode prev) {
       if (root == null) {
           return;
       }
       parent.put(root, prev);
       dfs(root.left, root);
       dfs(root.right, root);
       
    }
    
    private void searchK(TreeNode node, int k) {
        if (node == null) {
            return;
        }
        if (set.contains(node)) {
            return;  
        }   
        set.add(node);

        if (k == 0) {
            res.add(node.val);
        }
        
        searchK(node.left, k - 1);
        searchK(node.right, k - 1);
        searchK(parent.get(node), k-1);
    }
}
```
