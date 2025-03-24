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

binary_search
```python
from typing import List

# 使用二分查找查找位置
def binary_search(arr: List[int], target: int) -> int:
    lo, hi = 0, len(arr)
    while lo < hi:
        mid = (lo + hi) // 2
        if arr[mid] < target:
            lo = mid + 1
        else:
            hi = mid
    return lo

# 计算窗口的中位数
def get_median(medians: List[int], k: int) -> float:
    if k % 2 == 1:
        return medians[k // 2]
    else:
        return (medians[k // 2] + medians[k // 2 - 1]) / 2

class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        # 当窗口大小为1时，中位数就是每个元素本身
        if k == 1:
            return list(map(float, nums))

        # 初始化窗口，使用排序后的前 k 个元素
        medians = sorted(nums[:k])
        res = [get_median(medians, k)]  # 计算并添加第一个窗口的中位数

        # 如果窗口大小等于数组长度，直接返回结果
        if k == len(nums):
            return res

        # 遍历滑动窗口中的其他元素
        for i in range(k, len(nums)):
            # 移除窗口最左边的元素
            pos_to_remove = binary_search(medians, nums[i - k])
            medians.pop(pos_to_remove)

            # 插入当前元素并保持窗口有序
            pos_to_insert = binary_search(medians, nums[i])
            medians.insert(pos_to_insert, nums[i])

            # 计算新的窗口的中位数并添加到结果中
            res.append(get_median(medians, k))

        return res
```



python 有一类数据结构 sortedcontainers, 里面的add, remove 是基于红黑树实现的，时间复杂度都是 logN, 这里可以用sortedList

```python
from sortedcontainers import SortedList

class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        def get_median():
            median = window[len(window) // 2]
            if len(window) % 2 == 0:
                median += window[len(window) // 2 - 1]
                median /= 2
            return median

        medians = []
        window = SortedList(nums[:k])
        medians.append(get_median())
        for i in range(k, len(nums)):  # O(n)
            window.add(nums[i])  # O(log k)
            window.remove(nums[i - k])  # O(log k) 
            medians.append(get_median())
        
        return medians
```

