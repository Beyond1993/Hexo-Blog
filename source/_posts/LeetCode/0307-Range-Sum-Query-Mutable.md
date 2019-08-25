---
title: 0307 Range Sum Query Mutable
date: 2018-01-17 23:13:58
categories: LeetCode
tags:
---

Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.

The update(i, val) function modifies nums by updating the element at index i to val.
Example:
Given nums = [1, 3, 5]

sumRange(0, 2) -> 9
update(1, 2)
sumRange(0, 2) -> 8
Note:
The array is only modifiable by the update function.
You may assume the number of calls to update and sumRange function is distributed evenly.

在imutable 的时候，这个可以通过算区间和来快速的query range sum, 但是如果数据在不断的update, 因为每更新一个点，都要将相关的点更新。这种cost 非常大.

我们要保持 update 和 query 都保持 logn， 这就需要保持一个树的结构.

```java
public class NumArray {
    class SegmentTreeNode {
        int start, end, sum;
        SegmentTreeNode left, right;
        public SegmentTreeNode(int start, int end) {
            this.start = start;
            this.end = end;
            this.left = null;
            this.right = null;
            this.sum = 0;
        }
    }
    SegmentTreeNode root = null;
    public NumArray(int[] nums) { root = buildTree(nums, 0, nums.length-1);}
    private SegmentTreeNode buildTree(int[] nums, int start, int end) {
        if (start > end) { return null; }
        SegmentTreeNode ret = new SegmentTreeNode(start, end);
        if (start == end) {
            ret.sum = nums[start];
        } else {
            int mid = start  + (end - start) / 2;             
            ret.left = buildTree(nums, start, mid);
            ret.right = buildTree(nums, mid + 1, end);
            ret.sum = ret.left.sum + ret.right.sum;
        }         
        return ret;
    }
    void update(int i, int val) { update(root, i, val); }
    
    void update(SegmentTreeNode root, int pos, int val) {
        if (root.start == root.end) {
           root.sum = val;
        } else {
            int mid = root.start + (root.end - root.start) / 2;
            if (pos <= mid) {update(root.left, pos, val);} 
            else { update(root.right, pos, val); }
            root.sum = root.left.sum + root.right.sum;
        }
    }

    public int sumRange(int i, int j) { return sumRange(root, i, j); }
    
    public int sumRange(SegmentTreeNode root, int start, int end) {
        if (root.end == end && root.start == start) { return root.sum; } 
        int mid = root.start + (root.end - root.start) / 2;
        if (end <= mid) {
            return sumRange(root.left, start, end);
        } else if (start >= mid+1) {
            return sumRange(root.right, start, end);
        }  else {    
            return sumRange(root.right, mid+1, end) + sumRange(root.left, start, mid);
        }
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * NumArray obj = new NumArray(nums);
 * obj.update(i,val);
 * int param_2 = obj.sumRange(i,j);
 */
```
```java
class NumArray {
    
    class Node {
        int start;
        int end;
        Node left;
        Node right;
        int sum;
        
        Node (int s, int e) {
            this.start = s;
            this.end = e;
        }
    }
    
    int[] innerNums;
    Node root;
    
    private Node build(int l, int r) {
        if (l == r) {
            Node node = new Node(l, r);
            node.sum = this.innerNums[l];
            return node;
        }
        Node curNode = new Node(l,r);
        int mid = (l + r) >>> 1;
        curNode.left = build(l, mid);
        curNode.right = build(mid+1, r);
        
        curNode.sum = curNode.left.sum + curNode.right.sum;
        
        return curNode;
        
    }
    
    public NumArray(int[] nums) {
        if (nums == null || nums.length == 0) return; 
        
        this.innerNums = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            this.innerNums[i] = nums[i];
        }
        
        this.root = build(0, nums.length - 1);
    }
    
    
    private void update(int i, int val, Node root) {
        if (root.start == root.end && root.start == i) {
            root.sum = val;
            return;
        }
        
        int mid = (root.start + root.end) >>> 1;
        
        if (i <= mid ) {
            update(i, val, root.left);
        } else {
            update(i, val, root.right);
        }
        
        root.sum = root.left.sum + root.right.sum;
    }
    
    public void update(int i, int val) {
        update(i, val, this.root);
    }
    private int sumRange(int i, int j, Node root) {
        if (root.start == i && root.end == j) {
            return root.sum;
        }
        int mid = (root.start + root.end) >>> 1;
        int sum = 0;
        if (mid >= j) {
            sum = sumRange(i, j, root.left);
        } else if (mid < i) {
            sum = sumRange(i, j, root.right);
        } else {
            sum = sumRange(i, mid, root.left) + sumRange(mid + 1, j, root.right);
        }
        return sum;
    }
    public int sumRange(int i, int j) {
       return sumRange(i, j, this.root);   
    }
}
```

