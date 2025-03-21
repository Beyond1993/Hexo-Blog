---
title: 0875 Koko Eating Bananas
date: 2025-03-21 08:50:02
categories: LeetCode
tags:
---

Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

Return the minimum integer k such that she can eat all the bananas within h hours.

 

Example 1:

Input: piles = [3,6,7,11], h = 8
Output: 4
Example 2:

Input: piles = [30,11,23,4,20], h = 5
Output: 30
Example 3:

Input: piles = [30,11,23,4,20], h = 6
Output: 23


```python

class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        left, right = 1, max(piles)

        while left < right:
            mid = left + (right - left) // 2
            if self.canFinish(mid, piles, h):
                right = mid
            else:
                left = mid + 1      
        return left

    def canFinish(self, k, piles, h):
        total_hour = 0
        for i in range(len(piles)):
            ## 如果能整除，就不需要 + 1
            if piles[i] % k == 0:
                total_hour += (piles[i] // k)
            else:
                total_hour += (piles[i] // k) + 1
            
        return total_hour <= h
```


```python

class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        l = 1
        r = max(piles)
        while l  < r :
            mid = l + (r - l) // 2
            hours = self.get_hours(mid, piles)
            if hours > h:
                l = mid + 1
            else:
                r = mid
        return l

    def get_hours(self, nums_per_hour, piles) -> int:
        hours = 0
        for n in piles:
            hours += math.ceil(n / nums_per_hour )
        return hours
```
