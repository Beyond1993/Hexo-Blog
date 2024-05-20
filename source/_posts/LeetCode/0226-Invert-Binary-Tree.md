---
title: 0226 Invert Binary Tree
date: 2017-12-14 18:54:29
categories: LeetCode
tags:
---

反转一个二叉树，因为homebrew 作者出了名。

这题看上去简单，其实有点小trick.

反转二叉树，不就是把**右子树赋值给左子树，左子树赋值给右子树**

所以很容易写出如下代码

```java
public TreeNode invertTree(TreeNode root) {
  if (root == null) {
    return null;
  }

  root.left = invertTree(root.left);
  root.right = invertTree(root.left;
  
  return root;
}
```

这种bug的 原因就是 root.left = invertTree(root.left); 改变了root.left的值。

其实这题就是树的swap, 要提前保留中间结果

所以可以改写成
```java
public TreeNode invertTree(TreeNode root) {
  if (root == null) return null;

  TreeNode left = invertTree(root.left);
  
  root.left = invertTree(root.right);
  root.right = left;
  return root;
}
```
为了 美观，对称，最后改写成:

```java
public TreeNode invertTree(TreeNode root) {
  if (root == null) return null;
  TreeNode left = invertTree(root.left);
  TreeNode right = invertTree(root.right);
  
  root.left = right;
  root.right = left;
  return root;
}
```

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root :
            return root
        left = self.invertTree(root.left) ## save it as temp value
        root.left = self.invertTree(root.right)
        root.right = left
        return root     
        
```
