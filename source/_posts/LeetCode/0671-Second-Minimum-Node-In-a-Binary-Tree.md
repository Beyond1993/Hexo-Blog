---
title: 0671 Second Minimum Node In a Binary Tree
date: 2019-07-14 18:23:45
categories:
tags:
---


```txt
        1
       / \
      1   3
     / \ / \
    1  2 3 4
```

This is the corner case

```java
class Solution {
    int min1;
    long ans = Long.MAX_VALUE;

    public void dfs(TreeNode root) {
        if (root != null) {
            if (min1 < root.val && root.val < ans) {
                ans = root.val;
            } else if (min1 == root.val) {
                dfs(root.left);
                dfs(root.right);
            }
        }
    }
    public int findSecondMinimumValue(TreeNode root) {
        min1 = root.val;
        dfs(root);
        return ans < Long.MAX_VALUE ? (int) ans : -1;
    }
}
```

