---
title: 0958 Check Completeness Of A Binary Tree
date: 2024-12-27 11:36:40
categories: LeetCode
tags:
---


BFS
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isCompleteTree(self, root: Optional[TreeNode]) -> bool:
        ## 如果None 不是最后一个元素
        ## 也就是说如果已经出现了None, 后面还有非空的节点，说明不是完全二叉树
        q = collections.deque()
        q.append(root)
        isNoneSeen = False
        while q :
            cur = q.popleft()
            
            if cur is None: 
                isNoneSeen = True
            else:
                if isNoneSeen:
                    return False
                q.append(cur.left)
                q.append(cur.right)
        
        return True

```


dfs
```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

from typing import Optional

class Solution:
    def countNodes(self, root: Optional[TreeNode]) -> int:
        """Helper function to count the total number of nodes in the tree."""
        if root is None:
            return 0
        return 1 + self.countNodes(root.left) + self.countNodes(root.right)
    
    def dfs(self, node: Optional[TreeNode], index: int, total_nodes: int) -> bool:
        """DFS to check if the tree satisfies the completeness condition."""
        if node is None:
            return True
        # If index exceeds or equals the total number of nodes, the tree is not complete
        if index >= total_nodes:
            return False
        # Check both left and right subtrees
        return (self.dfs(node.left, 2 * index + 1, total_nodes) and
                self.dfs(node.right, 2 * index + 2, total_nodes))
    
    def isCompleteTree(self, root: Optional[TreeNode]) -> bool:
        """Main function to check if the tree is complete using DFS."""
        # First, count the total number of nodes
        total_nodes = self.countNodes(root)
        # Then, perform DFS to validate the completeness condition
        return self.dfs(root, 0, total_nodes)


```
