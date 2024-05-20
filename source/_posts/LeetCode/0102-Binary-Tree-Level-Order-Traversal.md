---
title: 0102 Binary Tree Level Order Traversal
date: 2024-05-20 07:01:29
categories: LeetCode
tags:
---

Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

Example 1:
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]

Example 2:
Input: root = [1]
Output: [[1]]

Example 3:
Input: root = []
Output: []

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []
        res = []
        q = []
        q.append(root)
        while(q) :
            size = len(q)
            oneRes = []
            for i in range(size):
                cur = q.pop(0)
                oneRes.append(cur.val)
                if cur.left :
                    q.append(cur.left)
                if cur.right : 
                    q.append(cur.right)
            res.append(oneRes)
        return res                
```

