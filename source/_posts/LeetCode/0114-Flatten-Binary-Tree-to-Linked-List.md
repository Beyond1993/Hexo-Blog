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

这题的着眼点就是, 我不管用什么遍历, 对于当前这个点, 我要怎么处理.

## 前序遍历:

```text
         1                                 1
        / \                                  \      realRight --> 5
       2   5     ---处理 1 这个点 -->          2                    \
      / \   \                                / \                    6
     3   4   6                              3   4


   2                         2  
  / \     -- 处理 2 -->       \      realRight  --> 4
 3   4                         3 
```

最后处理的 realRight, 其实就是 最后调用 flattenPre(realRight) 变成了 root

要知道 preorder , 是 2,3,4, 所以 在4 这点, 3 是 lastVisited, lastVisited.right = root
3 的 lastVisited 是 2

```java
public void flattenPre(TreeNode root) {
   if (root == null) return;

   TreeNode realRight = root.right;
   if (lastVisited != null) {
       lastVisited.left = null;
       lastVisited.right = root; // prev
   }
   lastVisited = root;
   flattenPre(root.left);
   flattenPre(realRight);
}
```

中序遍历: 找到跟节点
```java
public void flattenIn(TreeNode root) {
   if (root == null) return;
   flattenIn(root.left);
   if (root.left != null) {
       TreeNode temp = root.left;
       while (temp.right != null) {
           temp = temp.right;
       }
       temp.right = root.right;
       root.right = root.left;
       root.left = null;
   }
   flattenIn(root.right);
}
```

后序遍历:
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

这两种后序遍历的写法，很奇妙，代码顺序不同，其实本质是一样的， 递归到上一层，就是想当于在调用递归前设置的变量

```java
public void flatten(TreeNode root) {
  if (root == null) return;
        
  TreeNode left = root.left;
  TreeNode right = root.right;
        
  root.left = null;
        
  flatten(left);
  flatten(right);
        
  root.right = left;
  while (root.right != null) { 
    root = root.right;
  }
  root.right = right;
}
```

Reversed Preorder Recursion
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

Reversed Preorder Iteration
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


One Pointer
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


In-Place
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
