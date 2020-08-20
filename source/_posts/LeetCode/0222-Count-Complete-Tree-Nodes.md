---
title: 0222 Count Complete Tree Nodes
date: 2020-05-24 01:09:57
categories: LeetCode
tags:
---

    1
   / \
  2   3
 /     
4    
        
        
==> h => 最后一层个数

3 => 2^(h) = 4 
    
    2^h == > log(2^h) = h * log2 = > h ==> log(n)
        
4th  7th

k th node 是否在这棵complete tree 上

k 4 ~ 7
        
5th 在这棵树上，5 ~ 7
        
6 th， 6，7

7 th. 6
        
isInTheTree(int k)
        
k = 5, k = 2, k = 1  

时间复杂度计算:

- 算高度 h

- binary search log(2^h) 

- k th node 是否在这棵complete tree 上: 2h
h + 2log2 * h^2 == > h^2 ==> log(n) * log(n) >>


```java
class Solution {
    public int countNodes(TreeNode root) {
        int h = getHeight(root);
        int start = (int)Math.pow(2, h) ;
        int end  =  (int)Math.pow(2, h + 1) - 1;
        
        while(start + 1 < end) {
             int mid = start + (end - start) / 2;
             if (isInTheTree(mid, root)) {
                start = mid;
             } else {
                 end = mid - 1;
             }
         }
        
         if (isInTheTree(end, root)) {
             return end;
         }
        
         return start;
        
    }
    
    private int getHeight(TreeNode root) {
        if (root == null) {
            return -1;
        }
        
        return getHeight(root.left) + 1;
    }
    
    private boolean isInTheTree(int k, TreeNode root) {
        List<Integer> path = new ArrayList<Integer>();
        while(k >= 1) {
            path.add(k);
            k = k / 2;
        }
        TreeNode cur = root;
        for (int i = path.size() - 2; i >= 0; i--) {
            int v = path.get(i);
            
            if (v % 2 == 0) {
                if (cur.left == null) return false;
                cur = cur.left;
            } else {
                if (cur.right == null) return false;
                cur = cur.right;
            }
        }
        return true;
    }
}
```
