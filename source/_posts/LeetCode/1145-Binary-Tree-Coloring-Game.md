---
title: 1145. Binary Tree Coloring Game
date: 2019-08-04 03:50:51
categories: LeetCode
tags:
---

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
    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        if (root == null) {
            return false;
        }
        
        if (root.val == x) {
            int[] temp = dfs(root);
            int leftCount = temp[0];
            int rightCount = temp[1];
            int remain = n - leftCount - rightCount - 1;
            if (remain > (leftCount + rightCount) || leftCount > (rightCount + remain) || rightCount > (leftCount + remain)) {
                return true;
            }
           
            return false;
        }
        
        return btreeGameWinningMove(root.left, n, x) || btreeGameWinningMove(root.right, n, x);    
    }
    
    
    private int[] dfs(TreeNode root) {
        if (root == null) {
            int[] res = {0,0};
            return res;
        }
        
        int[] left = dfs(root.left);
        int[] right = dfs(root.right);
        
        int[] res = new int[2];
        res[0] = left;
        res[1] = right;
        return res;
    }
}
