---
title: 0303 Range Sum Query - Immutable
date: 2019-08-19 00:09:22
categories: LeetCode
tags:
---


```java
class NumArray {

    int[] preSum;
    public NumArray(int[] nums) {
        if (nums.length == 0) return;
        preSum = new int[nums.length];
        preSum[0] = nums[0];
        for (int i = 1; i < nums.length; i++) {
            preSum[i] = preSum[i-1] + nums[i];
            //System.out.println(preSum[i]);
        }
        
    }
    
    public int sumRange(int i, int j) {
        return i == 0 ?  preSum[j] : preSum[j] - preSum[i-1];
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * NumArray obj = new NumArray(nums);
 * int param_1 = obj.sumRange(i,j);
 */
```
