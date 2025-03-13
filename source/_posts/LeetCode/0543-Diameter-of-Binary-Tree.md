---
title: 0543. Diameter of Binary Tree
date: 2017-12-14 19:10:58
categories: LeetCode
tags:
---

求一棵树的直径


分别求左子树， 右子树高度，然后加上自己， left + right + 1

然后用一个全局变量 d = max(left + right + 1, d)

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        d = -1
        def singleHeight(root):
            nonlocal d
            if not root: return 0

            left = singleHeight(root.left)
            right = singleHeight(root.right)

            d = max(left + right + 1, d)

            return max(left, right) + 1
        singleHeight(root)
        return d - 1
```
不用全局变量 的写法
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        def singleHeight(root):
            if not root: return 0,0

            left, right_d = singleHeight(root.left)
            right,left_d = singleHeight(root.right)

            d = max(left + right + 1, right_d, left_d)

            return max(left,right) + 1, d
        _, d = singleHeight(root)
        return d - 1
```
