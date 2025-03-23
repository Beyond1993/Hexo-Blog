---
title: 0480 Sliding Window Median
date: 2025-03-23 07:07:01
categories: LeetCode
tags:
---

这题是找窗口里的中位数, 不是平均数

没有delayed clean 版本

```python
from heapq import heappush, heappop
from typing import List

class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        small = []  # Max Heap (store negative values)
        large = []  # Min Heap
        result = []

        def add(num):
            if not small or num <= -small[0]:
                heappush(small, -num)
            else:
                heappush(large, num)
            balance()

        def remove(num):
            if num <= -small[0]:
                small.remove(-num)  # Remove element from small heap (O(n))
                heapify(small)  # Rebuild heap (O(n log n))
            else:
                large.remove(num)  # Remove element from large heap (O(n))
                heapify(large)  # Rebuild heap (O(n log n))
            balance()

        def balance():
            if len(small) > len(large) + 1:
                heappush(large, -heappop(small))
            elif len(small) < len(large):
                heappush(small, -heappop(large))

        def get_median():
            if len(small) > len(large):
                return float(-small[0])
            return (-small[0] + large[0]) / 2.0

        # Add first k elements
        for i in range(k):
            add(nums[i])
        result.append(get_median())

        # Move the window and calculate the median
        for i in range(k, len(nums)):
            add(nums[i])
            remove(nums[i - k])
            result.append(get_median())

        return result
```

delayed clean, 减少了堆重建的次数，

总结：
没有延迟删除的情况：每次删除都会导致堆重建，堆的重构次数等于删除操作次数 n - k + 1。

使用延迟删除的情况：每次滑动窗口时，不会每次都删除并重建堆，而是延迟删除直到需要清理堆顶元素时才进行，因此堆的重构次数大大减少，通常只有在访问堆顶元素时才进行清理。

时间复杂 是一样的，只是操作的地方不同，减少了重建堆的次数

```python
from heapq import heappush, heappop
from collections import defaultdict
from typing import List

class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        small = []  # Max Heap (store negative values)
        large = []  # Min Heap
        delayed = defaultdict(int)
        sizes = {'small': 0, 'large': 0}
        result = []

        def add(num):
            if not small or num <= -small[0]:
                heappush(small, -num)
                sizes['small'] += 1
            else:
                heappush(large, num)
                sizes['large'] += 1
            balance()

        def remove(num):
            delayed[num] += 1
            if num <= -small[0]:
                sizes['small'] -= 1
            else:
                sizes['large'] -= 1
            clean_heap()
            balance()

        def balance():
            if sizes['small'] > sizes['large'] + 1:
                heappush(large, -heappop(small))
                sizes['small'] -= 1
                sizes['large'] += 1
            elif sizes['small'] < sizes['large']:
                heappush(small, -heappop(large))
                sizes['small'] += 1
                sizes['large'] -= 1
            clean_heap()

        def clean_heap():
            while small and delayed[-small[0]] > 0:
                delayed[-small[0]] -= 1
                heappop(small)
            while large and delayed[large[0]] > 0:
                delayed[large[0]] -= 1
                heappop(large)

        def get_median():
            if sizes['small'] > sizes['large']:
                return float(-small[0])
            return (-small[0] + large[0]) / 2.0

        for i in range(k):
            add(nums[i])
        result.append(get_median())

        for i in range(k, len(nums)):
            add(nums[i])
            remove(nums[i - k])
            result.append(get_median())

        return result
```
