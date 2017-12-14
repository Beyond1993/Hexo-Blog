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
    TreeNode right = helper(preStart + index - inStart + 1, index + 1, inEnd, preorder, inorder);
    root.left = left;
    root.right = right;
    return root;
}
public TreeNode buildTree(int[] preorder, int[] inorder) {
    return helper(0, 0, preorder.length - 1, preorder, inorder);
}
```

