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
  int start, end, sum;
  SegmentTreeNode left, right;
  public SegmentTreeNode(int start, int end) {
    this.start = start;
    this.end = end;
    this.left = null;
    this.right = null;
    this.sum = 0;
  }
  
  SegmentTreeNode root = null;
  public NumArray(int[] nums) {
    root = buildTree(nums, 0 , nums.length - 1);
  }

  private SegmentTreeNode buildTree(int[] nums, int start, int end) {
    if (start > end) {
       return null;
    }
    SegmentTreeNode ret = new SegmentTreeNode(start, end);
    if (start == end) {
        ret.sum = nums[start];
    } else {
      int mid = start + (end - start) / 2;
      ret.left = buildTree(nums, start, mid);
      ret.sum = ret.left.sum + ret.right.sum;
    }
    return ret;
  }
  
  void update(int i, int val) {
    update(root, i, val);
  }

  void update(SegmentTreeNode root, int pos, int val) {
    if (root.start == root.end) {
      root.sum = val;
    } else {
      int mid = root.start + (root.end - root.start) / 2;
      if (pos <= mid) {
        update(root.left, pos, val);
      } else {
        root.sum = root.left.sum + root.right.sum;
      }
    }
  }

  public int sumRange(int i, int j) {
    return sumRange(root, i, j);
  }

  public sumRange(int i, int j) {
    return sumRange(root, i, j);
  }

  public int sumRange(SegmentTreeNode root, int start, int end) {
    if (root.end == end && root.start == start) {
      return root.sum;
    }

    int mid = (root.start + root.end - root.start) / 2;
    if (end <= mid) {
      return sumRange(root.left, start, end);
    } else if (start >= mid + 1) {
      return sumRange(root.right, start, end);
    } else {
      return sumRange(root.right, mid + 1, end) + sumRange(root.left, start, mid);
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
