---
title: 0105 Construct Binary Tree from Preorder and Inorder Traversal
date: 2017-12-14 17:59:54
categories: LeetCode
tags:
---

Given preorder and inorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.


这题很简单， 就是直接构造一棵树。先通过前序遍历找到root, 再通过inorder找
左右子树的范围
```java
private TreeNode helper(int preStart, int inStart, int inEnd, int[] preorder, int[] inorder) {
    if (preStart > preorder.length - 1 || inStart > inEnd) {
        return null;
    }
    TreeNode root = new TreeNode(preorder[preStart]);
    int index = 0;
    for (int i = inStart; i <= inEnd; i++) {
        if (inorder[i] == root.val) {
            index = i;
            break;
        }
    }
    TreeNode left = helper(preStart + 1, inStart, index- 1, preorder, inorder);
    // index - inStart + 1 是左子树的长度(个数)
    TreeNode right = helper(preStart + index - inStart + 1, index + 1, inEnd, preorder, inorder);
    root.left = left;
    root.right = right;
    return root;
}
public TreeNode buildTree(int[] preorder, int[] inorder) {
    return helper(0, 0, preorder.length - 1, preorder, inorder);
}
```

这题还有迭代写法
```java
```


```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:

        def helper(pre_start, in_start, in_end):
            if pre_start >= len(preorder) or in_start > in_end:
                return None
           
            root = TreeNode(preorder[pre_start])

            ## find inorder index
            index = 0
            for i in range(in_start, in_end + 1, 1):
                if inorder[i] == preorder[pre_start]:
                    index = i
                    break

            left = helper(pre_start + 1, in_start, index - 1)
            right = helper(pre_start + index - in_start + 1, index + 1, in_end)
            root.left = left
            root.right = right
            return root
        return helper(0, 0, len(preorder) - 1)
```

简化:

```python
from typing import List, Optional

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        
        def helper(pre_start, in_start, in_end):
            # If there are no elements to construct the tree
            if pre_start >= len(preorder) or in_start > in_end:
                return None
            
            # The first element in preorder is the root
            root = TreeNode(preorder[pre_start])
            
            # Find the index of the root in inorder
            index = inorder.index(preorder[pre_start], in_start, in_end + 1)

            # Construct the left and right subtrees
            root.left = helper(pre_start + 1, in_start, index - 1)
            root.right = helper(pre_start + index - in_start + 1, index + 1, in_end)

            return root

        return helper(0, 0, len(inorder) - 1)
```

最简:
```python
def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        if not preorder or not inorder:
            return None
        root = TreeNode(preorder[0])
        mid = inorder.index(preorder[0])
        root.left = self.buildTree(preorder[1: mid + 1], inorder[:mid])
        root.right = self.buildTree(preorder[mid + 1: ], inorder[mid + 1:])
        return root
```


