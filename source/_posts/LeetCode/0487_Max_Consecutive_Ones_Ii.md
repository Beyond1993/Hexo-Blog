---
title: 0487 Max Consecutive Ones II
date: 2025-01-05 09:17:18
categories: LeetCode
tags:
---


```python
class Solution:
    def findMaxConsecutiveOnes(self, nums: List[int]) -> int:
        
        left, right = 0, 0
        res, k = 0, 1
        while right < len(nums):
            if nums[right] == 0:
                k -= 1
                
            while k < 0:
                if nums[left] == 0:
                    k += 1
                left += 1
            res = max(res, right - left + 1)
            right += 1
        return res
```

follow up
http://47.113.101.198/2025/01/04/LeetCode/1004_Max_Consecutive_Ones_Iii/
