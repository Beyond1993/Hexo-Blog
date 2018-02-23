---
title: 0114 Flatten Binary Tree to Linked List
date: 2018-02-22 00:52:46
categories: LeetCode
tags:
---

Given a binary tree, flatten it to a linked list in-place.

For example,
Given

```text
         1
        / \
       2   5
      / \   \
     3   4   6
```
The flattened tree should look like:
```text 
  1
    \
     2
      \
       3
        \
         4
          \
           5
            \
             6
```

这题的思路是 reverse order 遍历一棵二叉树. 和这题很相像的是 倒挂一棵二叉树

这题的思路，我们不要一上来就, 想创建一个链表。 想想如何 打印 1,2,3,4,5,6 这样就是先序遍历？ 但是我们要求是 

1 --> 2, 2 --> 3, 写成代码就是 cur.next = ？ 所以我们要，先输出 6,5,4,3,2,1. 反序输出. 而且当前 root.right = prev

好， 那问题来了， 为什么不能正向创建链表?

```java
public void flatten(TreeNode root) {
        if (root == null) return;
        
        TreeNode left = root.left;
        TreeNode right = root.right;
        
        root.left = null;
        
        flatten(left);
        flatten(right);
        
        root.right = left;
        TreeNode cur = root;
        while (cur.right != null) cur = cur.right;
        cur.right = right;
}
```

```java
public class Solution {
    public void flatten(TreeNode root) {
        if(root==null)
            return;
        flatten(root.left);
        flatten(root.right);
        TreeNode left  = root.left;
        TreeNode right = root.right;
        root.left  = null;
        root.right = left; 
        while(root.right!=null)
            root = root.right;
        root.right = right;
    }

}
```


```java
public class Solution {
    private static TreeNode pointer = null;
    
    public void flatten(TreeNode root) {
        if(root == null)
            return;
            
        if(pointer != null)
            pointer.right = root;
        
        pointer = root;
            
        TreeNode right = root.right;
        flatten(root.left);
        root.left = null;
        flatten(right);
    }
}
```

Recursion
```java
private TreeNode prev = null;

public void flatten(TreeNode root) {
    if (root == null)
        return;
    flatten(root.right);
    flatten(root.left);
    root.right = prev;
    root.left = null;
    prev = root;
}
```

Iteration
```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public void flatten(TreeNode root) {
        if (root == null) {
            return;
        }
        Stack<TreeNode> s = new Stack<TreeNode>();
        s.push(root);
        while(!s.isEmpty()) {
            TreeNode cur = s.pop();
            if (cur.right != null) {
                s.push(cur.right);
            }
            
            if (cur.left != null) {
                s.push(cur.left);
            }
            
            if (!s.isEmpty()) {
                cur.right = s.peek();
            }
            
            cur.left =null;
        }
    }
}
```

in-place
```java
class Solution {
public:
    void flatten(TreeNode *root) {
    TreeNode*now = root;
    while (now)
    {
      if(now->left)
      {
        //Find current node's prenode that links to current node's right subtree
        TreeNode* pre = now->left;
        while(pre->right)
        {
          pre = pre->right;
        }
        pre->right = now->right;
        //Use current node's left subtree to replace its right subtree(original right 
        //subtree is already linked by current node's prenode
        now->right = now->left;
        now->left = NULL;
      }
      now = now->right;
    }
    }
};
```

double linked list
```java

```
