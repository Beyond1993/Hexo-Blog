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
sum[i]表示局部最大sum，即以 i 作为结尾的连续子数组最大和, 要注意的一点是, 最后 sum[n-1] 表示的是以n-1 为结尾的连续子数组最大和,所以不能直接返回 sum[n-1],
而是要返回这个dp 过程中的最大值.

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

```python
def maxSubArray(self, nums: List[int]) -> int:
        n = len(nums)
        sum_arr = [0] * n
        max_val = nums[0]
        sum_arr[0] = nums[0]
        for i in range(1, n):
            sum_arr[i] = max(nums[i], sum_arr[i-1] + nums[i])
            max_val = max(max_val, sum_arr[i])
        return max_val
```

可以把sum_arr 优化成 一个constant 变量

```python
def maxSubArray(self, nums: List[int]) -> int:
       n = len(nums)
       max_val = nums[0]
       sum_arr = 0
       for i in range(len(nums)):
        sum_arr = max(nums[i], sum_arr + nums[i])
        max_val = max(max_val, sum_arr)
       return max_val
```


另外还有双指针写法
