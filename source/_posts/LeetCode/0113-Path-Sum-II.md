---
title: 0113 Path Sum IV
date: 2018-08-04 11:25:34
categories: LeetCode
tags:
---

If the depth of a tree is smaller than 5, then this tree can be represented by a list of three-digits integers.

For each integer in this list:
The hundreds digit represents the depth D of this node, 1 <= D <= 4.
The tens digit represents the position P of this node in the level it belongs to, 1 <= P <= 8. The position is the same as that in a full binary tree.
The units digit represents the value V of this node, 0 <= V <= 9.
Given a list of ascending three-digits integers representing a binary with the depth smaller than 5. You need to return the sum of all paths from the root towards the leaves.

Example 1:
Input: [113, 215, 221]
Output: 12
Explanation: 
The tree that the list represents is:
    3
   / \
  5   1

The path sum is (3 + 5) + (3 + 1) = 12.
Example 2:
Input: [113, 221]
Output: 4
Explanation: 
The tree that the list represents is: 
    3
     \
      1

The path sum is (3 + 1) = 4.

这是经典的写法.

```java
public class Solution {
    private void search(List<List<Integer>> ans, List<Integer> list, TreeNode root, int sum) {
        if (root == null) return;
        
        list.add(root.val);
        if (sum == root.val && root.left == null && root.right == null) {
            ans.add(new ArrayList(list));
            list.remove(list.size() - 1);
            return;
        }
        
        search(ans, list, root.left, sum - root.val);
        search(ans, list, root.right, sum -root.val);
        list.remove(list.size() - 1);
        
    }
    public List<List<Integer>> pathSum(TreeNode root, int sum) {
           List<List<Integer>> ans = new ArrayList<List<Integer>>();
           List<Integer> list = new ArrayList<Integer>();
           search(ans, list, root,sum);
           return ans;
    }
}
```

