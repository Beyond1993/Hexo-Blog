---
title: 0493 Reverse Pairs
date: 2020-08-31 03:16:09
categories: LeetCode
tags:
---

Given an array nums, we call (i, j) an important reverse pair if i < j and nums[i] > 2*nums[j].

You need to return the number of important reverse pairs in the given array.

Example1:

Input: [1,3,2,3,1]
Output: 2
Example2:

Input: [2,4,3,5,1]
Output: 3
Note:

The length of the given array will not exceed 50,000.
All the numbers in the input array are in the range of 32-bit integer.

最朴素的想法就是 N^2， 每一个元素，往后找一圈

```java
class Solution {
    public int reversePairs(int[] nums) {
        
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                long a = nums[i];
                long b = nums[j];
                if (a > 2 * b) {
                    count++;
                }
            }
        }
        return count;
    }
}
```

超时
