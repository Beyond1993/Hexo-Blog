---
title: 0045-Jump-Game-II
date: 2019-05-21 23:31:42
categories: LeetCode
tags:
---


Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Your goal is to reach the last index in the minimum number of jumps.

Example:

Input: [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2.
    Jump 1 step from index 0 to 1, then 3 steps to the last index.
Note:

You can assume that you can always reach the last index.

dp solution

```python
class Solution:
    def jump(self, nums):
        dp = [-1] * (len(nums) + 1)
        dp[0] = 0
        i = 0 
        while i < len(nums) and dp[i] != -1:
            for j in range(nums[i] + 1):
                if i + j < len(dp):
                    if dp[i + j] != -1:
                        dp[i + j] = min(dp[i+j], dp[i] + 1)
                    else:
                        dp[i+j] = dp[i] + 1
            i += 1
        return dp[len(nums) - 1]
```

