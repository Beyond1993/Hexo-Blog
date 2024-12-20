---
title: 0545 Boundary Of Binary Tree
date: 2024-12-20 07:09:19
categories: LeetCode
tags:
---

求一棵树的边界

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Solution:
    def __init__(self):
        self.res = []

    def boundaryOfBinaryTree(self, root: Optional['TreeNode']) -> List[int]:
        if not root:
            return self.res
        # If it's a single node (root is a leaf), return just the root value
        if not root.left and not root.right:
            self.res.append(root.val)
            return self.res

        # Start with the root value
        self.res.append(root.val)
        
        # Process the left boundary (if exists)
        self._getLeft(root.left)
        
        # Process the leaf nodes (bottom boundary)
        self._getBottom(root)
        
        # Process the right boundary (if exists)
        self._getRight(root.right)
        
        return self.res

    def _getLeft(self, root: Optional['TreeNode']):
        if not root or (not root.left and not root.right):
            return
        
        self.res.append(root.val)
        print(root.val)
        
        if root.left:
            self._getLeft(root.left)
        else:
            self._getLeft(root.right)

    def _getBottom(self, root: Optional['TreeNode']):
        if not root:
            return
        
        # Recursively traverse left subtree
        self._getBottom(root.left)
        
        # If it's a leaf node, add it to the result
        if not root.left and not root.right:
            self.res.append(root.val)
        
        # Recursively traverse right subtree
        self._getBottom(root.right)

    def _getRight(self, root: Optional['TreeNode']):
        if not root or (not root.left and not root.right):
            return
        
        # Recursively traverse right subtree
        if root.right:
            self._getRight(root.right)
        else:
            self._getRight(root.left)
        
        ## 因为右边界是从下往上看的，所以得 post order
        # Add root value after processing the right subtree
        self.res.append(root.val)
```
