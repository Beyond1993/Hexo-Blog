---
title: 1110 Delete Nodes And Return Forest
date: 2020-05-16 09:28:37
categories: LeetCode
tags:
---

Given the root of a binary tree, each node in the tree has a distinct value.

After deleting all nodes with a value in to_delete, we are left with a forest (a disjoint union of trees).

Return the roots of the trees in the remaining forest.  You may return the result in any order.

Example 1:

```txt
      1
     /  \
    2    3
   / \  / \
  4   5 6  7

```

Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
Output: [[1,2,null,4],[6],[7]]

这个题目的意思非常简单明确，一颗没有重复元素的二叉树，删除指定的节点，保留剩下的二叉树。

解法1: divide and conquer, 先遍历到叶子节点，再往回走，如果是要删除的节点，return null. 否则 return 这个节点。

唯一需要注意的就是这棵二叉树的根节点怎么处理。

```java
class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        Set<Integer> set = new HashSet<>();
        List<TreeNode> res = new ArrayList<>();
        for (int i : to_delete) {
            set.add(i);
        }
        TreeNode r = dfs(root, set, res);
        if (r != null) {
            res.add(r);
        }
        return res;
    }
    
    private TreeNode dfs(TreeNode node, Set<Integer> set, List<TreeNode> res) {
        if (node == null) return null;
        
        node.left = dfs(node.left, set, res);
        node.right = dfs(node.right, set, res);
        
        if (set.contains(node.val)) {
            if (node.left != null) {
                res.add(node.left);
            }
            if (node.right != null) res.add(node.right);
            return null;
        } else {
            return node;
        }
    }
}
```

可以先判断根节点:
```java
class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        Set<Integer> set = new HashSet<>();
        for (int i : to_delete) set.add(i);
        List<TreeNode> res = new ArrayList<>();
        if (!set.contains(root.val)) res.add(root);
        dfs(root, set, res);
        return res;
    }

    private TreeNode dfs(TreeNode node, Set<Integer> set, List<TreeNode> res) {
        if (node == null) {
            return null;
        }
        node.left = dfs(node.left, set, res);
        node.right = dfs(node.right, set, res);
        if (set.contains(node.val)) {
            if (node.left != null) res.add(node.left);
            if (node.right != null) res.add(node.right);
            return null;
        }
        return node;
    }
}
```

解法2: 
```java
class Solution {  
    Set<Integer> set;
    List<TreeNode> res;
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        set = new HashSet<>();
        res = new ArrayList<>();
        for (int i : to_delete)
            set.add(i);
        helper(root, true);
        return res;
    }
    private TreeNode helper(TreeNode node, boolean lastDeleted) {
        if (node == null) return null;
        boolean curDeleted = set.contains(node.val);
        //加入的条件是 上一个节点要删除，当前节点不删除
        if (lastDeleted && !curDeleted) res.add(node);
        node.left = helper(node.left, curDeleted);
        node.right =  helper(node.right, curDeleted);
        return curDeleted ? null : node;
    }
}
```



解法3: 考虑左右子树 @[Claire](https://claireliang.com/)
```java
class Solution {
    List<TreeNode> result;
    Set<Integer> set;
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        result = new ArrayList<>();
        set = new HashSet<>();
        for(int i : to_delete) {
            set.add(i);
        }
        traverse(root, true);
        return result;
    }
    private void traverse(TreeNode root, boolean lastDeleted) {
        if(root == null) return;
        if(!set.contains(root.val) && lastDeleted) {
            result.add(root);
        }
        boolean removeLeft = root.left != null && set.contains(root.left.val);
        boolean removeRight = root.right != null && set.contains(root.right.val);
        
        if(removeLeft) {
            traverse(root.left.left, true);
            traverse(root.left.right, true);
            root.left = null;
        } else {
            traverse(root.left, set.contains(root.val));
        }
        
        if(removeRight) {
            traverse(root.right.left, true);
            traverse(root.right.right, true);
            root.right = null;
        } else {
            traverse(root.right, set.contains(root.val));
        }
    }
}
```
