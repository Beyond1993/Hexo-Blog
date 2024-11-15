---
title: 0041 First Missing Positive
date: 2018-02-18 03:10:00
categories: LeetCode
tags:
---

```python
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
    ## put 1 into index 0, put 2 into index 1, put 3 int index 2..
    ## find first missing positive number
    ## cycle sort
        n = len(nums)

        i = 0
        while i < n:
            #print(i)
            if nums[i] <= 0:
                i += 1 
                continue
            correct_idx = nums[i] - 1
            if correct_idx < n and nums[i] != nums[correct_idx]:
                nums[i], nums[correct_idx] = nums[correct_idx], nums[i]
            #    print(i , nums)
            else:
                i += 1
            
        ## sort from index 0
        for i in range(n):
            if nums[i] != i + 1: return i + 1
        
        return n + 1
```
