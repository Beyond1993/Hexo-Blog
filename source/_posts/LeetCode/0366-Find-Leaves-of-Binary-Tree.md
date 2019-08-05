---
title: 0366 Find Leaves of Binary Tree
date: 2019-08-05 02:12:57
categories: LeetCode
tags:
---

```java
public class Solution {
    List<List<Integer>> ans = new ArrayList<List<Integer>>();
    private int dfs(TreeNode root) {
        if (root == null) return -1;
        if (root.left == null && root.right == null) {
            if (ans.isEmpty()) {
                ans.add(new ArrayList<Integer>());
            }
            ans.get(0).add(root.val);
            return 0;
        }
        int left = dfs(root.left) + 1;
        int right = dfs(root.right) + 1;
        int level = Math.max(left, right);
        if (ans.size() < level + 1) {
            ans.add(new ArrayList<Integer>());    
        }
        ans.get(level).add(root.val);
        return level;
        
    }
    public List<List<Integer>> findLeaves(TreeNode root) {
        dfs(root);
        return ans;
    }
}
```


```java
/*
          1
         / \
        2   3
       / \     
      4   5   
      
对于 4 --> [[4]], 5 --> [[5]]   2 [[4,5], [2]]; 3 --> [3]
*/
public class Solution {
    
    public List<List<Integer>> findLeaves(TreeNode root) {
        if (root == null) return new ArrayList<>();
        
        List<List<Integer>> leftLeaves = findLeaves(root.left);
        List<List<Integer>> rightLeaves = findLeaves(root.right);
        
        int idx = 0;
        List<List<Integer>> res = new ArrayList<>();
        
        while(idx < leftLeaves.size() || idx < rightLeaves.size()) {
            List<Integer> tmp = new ArrayList<>();
            if (idx < leftLeaves.size()) {
                tmp.addAll(leftLeaves.get(idx));
            }
            if (idx < rightLeaves.size()) {
                tmp.addAll(rightLeaves.get(idx));
            }
            res.add(tmp);
            idx++;
        }
        
        List<Integer> list = new ArrayList<Integer>();
        list.add(root.val);
        res.add(list);
        return res;
        
    }
}
```
