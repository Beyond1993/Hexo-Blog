---
title: 1004 Max Consecutive Ones Iii
date: 2025-01-04 07:51:45
categories: LeetCode
tags:
---


```python
class Solution:
    def longestOnes(self, nums: List[int], k: int) -> int:
        
        left, max_len = 0, 0

        for right in range(len(nums)):
            
            if nums[right] == 0:
                k -= 1

            ## if k == 0, 则刚好满足条件，不需要判断 k
            while k < 0:
                if nums[left] == 0:
                    k += 1
                left += 1
            max_len = max(max_len, right - left + 1)      
        return max_len
```
