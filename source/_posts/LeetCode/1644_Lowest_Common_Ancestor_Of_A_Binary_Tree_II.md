---
title: 1644 Lowest Common Ancestor Of A Binary Tree II
date: 2024-12-29 11:37:25
categories: LeetCode
tags:
---


```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        p_found = False
        q_found = False

        def dfs(node):
            nonlocal p_found, q_found
            if not node: return None

            l = dfs(node.left)
            r = dfs(node.right)

            if node == p or node == q:
                if node == p:
                    p_found = True
                if node == q:
                    q_found = True
                return node

            if l and r:
                return node
            else:
                ## 因为是后序遍历，所以每个节点都会遍历到，并且返回的是上面的节点。
                return l or r
            
        res = dfs(root)
        return res if p_found and q_found else None
```

