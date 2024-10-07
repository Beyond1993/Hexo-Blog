---
title: 347 Top K Frequent Elements
date: 2024-10-07 09:31:41
categories: LeetCode
tags:
---

Time : N log k

```python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        heap = []

        for value, freq in collections.Counter(nums).items():
            heapq.heappush(heap, (freq, value))
            if len(heap) > k:
                heapq.heappop(heap)
        res = []
        while heap:
            res.append(heapq.heappop(heap)[1])
        return res
```
