---
title: 1676 Lowest Common Ancestor Of A Binary Tree IV
date: 2024-12-29 12:00:12
categories: LeetCode
tags:
---


```python
class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', nodes: 'List[TreeNode]') -> 'TreeNode':
        nodes_set = set(nodes)  # Convert nodes to a set for O(1) lookups

        def dfs(root):
            if not root:
                return None
            if root in nodes_set:  # If the current node is one of the targets
                return root

            left = dfs(root.left)
            right = dfs(root.right)

            if left and right:  # If nodes are found in both subtrees, root is the LCA
                return root
            return left if left else right  # Propagate non-null result

        return dfs(root)
```

