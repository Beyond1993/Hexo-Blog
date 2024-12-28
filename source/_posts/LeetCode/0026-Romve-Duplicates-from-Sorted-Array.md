---
title: 0026 Romve Duplicates from Sorted Array
date: 2018-02-09 01:22:54
categories: LeetCode
tags:
---


```python
class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        if len(nums) == 0: return 0
        if len(nums) == 1: return 1
        idx = 1

        for i in range(len(nums) - 1):
            if nums[i+1] != nums[i]:
                nums[idx] = nums[i+1]
                idx += 1
        
        return idx
```
