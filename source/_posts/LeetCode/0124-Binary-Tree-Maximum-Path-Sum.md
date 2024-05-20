---
title: 0124 Binary Tree Maximum Path Sum
date: 2024-05-20 06:02:20
categories: LeetCode
tags:
---

A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

The path sum of a path is the sum of the node's values in the path.

Given the root of a binary tree, return the maximum path sum of any non-empty path.


找到整个二叉树路径里 最大的sum, 不一定是从根结点开始。

注意这里的path 是只一条折线，不能出现分叉

比如: 只能算最左端到最右端的sum， 不能算13.
```txt
				5
			4		8
		11	     null 13    	4
	7						1	
```


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
class Solution {
    int max = Integer.MIN_VALUE;
    public int maxPathSum(TreeNode root) {
        dfs(root);
        return max;
    }
    
    private int dfs(TreeNode root) {
        if (root == null) {
            return 0;
        }
        
        int left = dfs(root.left);
        int right = dfs(root.right);
        
        if (left < 0) {
            left = 0;
        }
        
        if (right < 0) {
            right = 0;
        }
        
        max = Math.max(max, root.val + left + right);
        
        return Math.max(left,right) + root.val;
    }
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
    
    def maxPathSum(self, root: Optional[TreeNode]) -> int:
        maxSum = -float("inf")

        def helper(root: Optional[TreeNode]) -> int:
            nonlocal maxSum
            if not root:
                return 0

            helperLeft = max(helper(root.left), 0)
            helperRight = max(helper(root.right), 0)
            currMax = helperLeft + helperRight + root.val
            maxSum = max(maxSum, currMax)
            ## select either left or right
            return max(helperLeft, helperRight) + root.val
        helper(root)
        return maxSum

```



