---
title: 173_Binary_Search_Tree_Iterator
date: 2024-09-23 11:17:21
categories: LeetCode
tags:
---

第一个写法:

直接用一个arrary 去遍历所有bst node


time : O(N) space O(N)

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class BSTIterator:
    
    def __init__(self, root: Optional[TreeNode]):
        self.orderArr = []
        self.index = 0
        def dfs(root):
            if not root: return
            dfs(root.left)
            self.orderArr.append(root.val)
            dfs(root.right)
        
        dfs(root)

    def next(self) -> int:
        res = self.orderArr[self.index]
        self.index += 1
        return res

    def hasNext(self) -> bool:
        return self.index <= len(self.orderArr) - 1
        
# Your BSTIterator object will be instantiated and called as such:
# obj = BSTIterator(root)
# param_1 = obj.next()
# param_2 = obj.hasNext()
```


第二个写法

用stack 记录所有左子树node, next 再去遍历tree

time O(H), space O(H), 最坏情况会退化到 O(N), O(N)


```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class BSTIterator:
    
    def __init__(self, root: Optional[TreeNode]):
        self.stack = []
        cur = root
        while cur :
            self.stack.append(cur)
            cur = cur.left

    def next(self) -> int:
        res = self.stack.pop()
        cur = res.right
        while cur:
            self.stack.append(cur)
            cur = cur.left
        return res.val

    def hasNext(self) -> bool:
        return len(self.stack) > 0

# Your BSTIterator object will be instantiated and called as such:
# obj = BSTIterator(root)
# param_1 = obj.next()
# param_2 = obj.hasNext()
```
