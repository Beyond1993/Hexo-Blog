---
title: 0560 Subarray Sum Equals K
date: 2018-02-17 20:24:22
categories: LeetCode
tags:
---

Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.

Example 1:
Input:nums = [1,1,1], k = 2
Output: 2
Note:
1.The length of the array is in range [1, 20,000].
2.The range of numbers in the array is [-1000, 1000] and the range of the integer k is [-1e7, 1e7].


```java
public int subarraySum(int[] nums, int k) {
  Map<Integer, Integer> map = new HashMap<>();
  int result = 0, sum = 0;
  map.put(0,1);
  for (int i = 0; i < nums.length; i++) {
    sum += nums[i];
    result += map.getOrDefault(sum - target, 0);
    map.put(sum, map.getOrDefault(sum,0) + 1);
  }
  return result;
}
```