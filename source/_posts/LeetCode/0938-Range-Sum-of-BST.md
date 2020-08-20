---
title: 0938 Range Sum of BST
date: 2020-04-14 09:44:35
categories: LeetCode
tags:
---

Given the root node of a binary search tree, return the sum of values of all nodes with value between L and R (inclusive).

The binary search tree is guaranteed to have unique values.

 

Example 1:

Input: root = [10,5,15,3,7,null,18], L = 7, R = 15
Output: 32
Example 2:

Input: root = [10,5,15,3,7,13,18,1,null,6], L = 6, R = 10
Output: 23
 

Note:
1. The number of nodes in the tree is at most 10000.
2. The final answer is guaranteed to be less than 2^31.


这题是一个简单题。但是还是要一题多解。力求代码简洁。

```java
class Solution {
    int sum = 0;
    public int rangeSumBST(TreeNode root, int L, int R) {
        dfs(root, L, R);
        return sum;
    }
    
    private void dfs(TreeNode root, int L, int R) {
        if (root == null) {
            return;
        }
        //System.out.println(root.val);
        if (root.val <= R && root.val >= L) {
            sum += root.val;
        }
        if (root.val > L) {
          dfs(root.left, L, R);  
        }
        
        if (root.val < R) {
            dfs(root.right, L, R);
        }
    }
}
```

这种 Global variable 的思路虽然

但是不能够多次调用. 

如果用 int[] num = new int[1];

这种写法就显的很傻.

我们应该追寻最简洁的写法。

```java

class Solution {
    public int rangeSumBST(TreeNode root, int L, int R) {
        if (root == null) {
            return 0;
        }
        if (root.val < L) {
          return rangeSumBST(root.right, L, R);  
        }
        if (root.val > R) {
          return rangeSumBST(root.left, L, R);
        }
        return root.val + rangeSumBST(root.left, L, R) + rangeSumBST(root.right, L, R); 
    } 
}
```
