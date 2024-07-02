---
title: 704-Binary-Search
date: 2024-07-02 07:07:28
categories: LeetCode
tags:
---

注意python 里的int 整除是双斜线 //
单斜线 / 是 浮点除 

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l = 0
        r = len(nums) - 1

        while l < r:
           
            mid = r + (l - r) // 2

            if nums[mid] == target:
                return mid
            elif nums[mid] > target:
                r = mid - 1
            else:
                l = mid + 1
        
        if r == l and nums[r] == target:
            return r
        return -1
```
