---
title: 0094 Binary Tree Inorder Traversal
date: 2017-12-11 21:48:59
categories: LeetCode
tags:
---

https://leetcode.com/problems/binary-tree-inorder-traversal/description/

二叉树的中根遍历。

一共有四种写法:

http://blog.163.com/guo_linda/blog/static/1237730572010928251143/

## 递归版本:

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        res = []   
        def helper(root: Optional[TreeNode]):
            nonlocal res
            if not root:
                return 
            
            helper(root.left)
            res.append(root.val)
            helper(root.right)
        helper(root)
        return res    
        
```

## 非递归版本

最常见非递归DFS版本:

遍历的方向永远是 从右上角 到左下角，一层一层的

```txx
    /
   /  /
  /  /  /
V   V  V
```


```java
public List<Integer> inorderTraversal(TreeNode root) {
    List<Integer> list = new ArrayList<Integer>();
    if (root == null) {
        return list;
    }

    Stack<TreeNode> s = new Stack<TreeNode>();
    TreeNode p = root;
    while (!s.isEmpty() || p != null) {
        while(p != null) {
            s.push(p);
            p = p.left;
        }
        TreeNode node = s.pop();
        list.add(node.val);
        p = node.right;

    }
    return list;
}
```

非常规BFS 非递归版本

增加父指针版本



```java
public class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> list = new ArrayList<Integer>();
        if (root == null) {
            return list;
        }
        
        Stack<TreeNode> s = new Stack<TreeNode>();
        TreeNode p = root;
        while (!s.isEmpty() || p != null) {
            while(p != null) {
                s.push(p);
                p = p.left;
            }
            TreeNode node = s.pop();
            list.add(node.val);
            p = node.right;
            
        }
        return list;
    }
}
```



