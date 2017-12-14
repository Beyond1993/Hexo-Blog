---
title: 0450 Delete Node in a BST
date: 2017-12-14 18:40:31
categories: LeetCode
tags:
---

http://www.wayne.ink/2017/12/12/CMU-Course/CMU-08722-Data-Structures-Lecture-15/

删除BST 的节点。

这里给出一个递归的解法。

这种解法很有意思，用递归去删除一个节点，一边删除的时候，一边构造一棵树。

递归的好处是容易写，但是坏处是效率低. 容易爆栈
```java
public TreeNode deleteNode(TreeNode root, int key) {
    if (root == null) {
        return null;
    }

    if (key < root.val) {
        root.left = deleteNode(root.left, key);
    } else if (key > root.val){
        root.right = deleteNode(root.right, key);
    } else {
        if (root.left == null && root.right == null) {
            return null;
        } else if (root.left == null) {
            return root.right;
        } else if (root.right == null) {
            return root.left;
        } else {
            TreeNode node = findMin(root.right);
            root.val = node.val;
            root.right = deleteNode(root.right, root.val);
        }
    }
    return root;
}

private TreeNode findMin(TreeNode root) {
    TreeNode node = root;
    while(node.left != null) {
        node = node.left;
    }
    return node;
}
```
