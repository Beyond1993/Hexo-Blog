---
title: 0053 Maxium Subarray
date: 2018-01-07 00:48:21
categories: LeetCode
tags:
---

这题用动态规划

Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
the contiguous subarray [4,-1,2,1] has the largest sum = 6.

这题是非常简单的单序列动态规划
sum[i]表示局部最大sum，即0～i的最大和

按照生长的思维，用暴力的解法，算出每一个，subarray, 显然这里面包含了很多重复计算，也就是说sum[i] 是  sum[0 ~ i - 1] 相关的
```java
public int maxSubArray(int[] nums) {
    int n = nums.length;
    int[] sum = new int[n];
    int max = nums[0];
    sum[0] = nums[0]; 
    for (int i = 1; i < n; i++) {
        sum[i] = Math.max(nums[i], sum[i-1] + nums[i]) ;
        max = Math.max(max, sum[i]);
    }
    return max;
}
```


