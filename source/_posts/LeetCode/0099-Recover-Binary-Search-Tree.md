---
title: 0099 Recover Binary Search Tree
date: 2018-08-11 20:01:54
categories: LeetCode
tags:
---

Two elements of a binary search tree (BST) are swapped by mistake.

Recover the tree without changing its structure.

Example 1:

Input: [1,3,null,null,2]
```txt
   1
  /
 3
  \
   2
```

Output: [3,1,null,null,2]
```txt
   3
  /
 1
  \
   2
```
Example 2:

Input: [3,1,4,null,null,2]
```txt
  3
 / \
1   4
   /
  2
```
Output: [2,1,4,null,null,3]
```txt
  2
 / \
1   4
   /
  3
```

这题的思路很清晰， 就是BST 中序遍历 找到 两个顺序不符合的点，然后交换回去.


```java
public void recoverTree(TreeNode root) {
    TreeNode first = null;
    TreeNode second = null;
    TreeNode prev = null;
    TreeNode p = root;
    Stack<TreeNode> s = new Stack<TreeNode>();
    while(!s.isEmpty() || p != null) {
        while(p != null) {
            s.push(p);
            p = p.left;
        }
            
        TreeNode node = s.pop();
            
        if (prev !=null && prev.val > node.val) {
            if (first == null) {
                first = prev;
            }
            
            second = node;
        }
        prev = node;
        p = node.right;
    } 
    int tmp = first.val;
    first.val = second.val;
    second.val = tmp;
}
```
