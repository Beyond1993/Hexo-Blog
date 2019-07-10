---
title: 0145 Binary Tree Posterorder Traversal
date: 2019-07-10 02:35:17
categories: LeetCode
tags:
---





```java
class Solution {
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> res = new ArrayList<Integer>();
        if (root == null) {
            return res;
        }
        
        Stack<TreeNode> stack = new Stack<>();
        
        stack.push(root);
        // break the tree, actually is visited
        while(!stack.isEmpty()) {
            TreeNode cur = stack.pop();
            if (cur == null) continue;
            if (cur.right == null && cur.left == null) {
                res.add(cur.val);
            } else {
                stack.push(new TreeNode(cur.val)); // new a Node , temp variable is not necessary.
            }
            
            stack.push(cur.right);
            stack.push(cur.left);
        }
        return res;
    }
}
```
