---
title: LeetCode-Tree
date: 2024-04-25 22:41:41
categories: LeetCode-Index
tags: tree
---

Tree:

DFS

BFS

Inorder, 

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        res = []   
        def helper(root: Optional[TreeNode]):
            nonlocal res
            if not root:
                return 
            
            helper(root.left)
            res.append(root.val)
            helper(root.right)
        helper(root)
        return res    
        
```

Preorder, 

Postorder


