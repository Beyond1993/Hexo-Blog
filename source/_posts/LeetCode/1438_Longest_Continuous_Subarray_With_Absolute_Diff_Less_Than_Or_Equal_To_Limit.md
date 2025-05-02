---
title: >-
  1438 Longest Continuous Subarray With Absolute Diff Less Than Or Equal To
  Limit
date: 2025-05-02 07:55:09
categories: LeetCode
tags:
---

给你一个整数数组 nums 和一个整数 limit。
请你找出一个最长的连续子数组，这个子数组中 任意两个元素的差值的绝对值都不超过 limit。

返回这个子数组的长度。

Nlog(N)

堆里存的是 value 和 index， 比较的时候比的是index
```python
class Solution:
    def longestSubarray(self, nums: List[int], limit: int) -> int:
        maxHeap = []  # 最大堆，存 (-值, 索引)
        minHeap = []  # 最小堆，存 (值, 索引)
        left = 0
        result = 0

        for right in range(len(nums)):
            # 把当前元素加入两个堆
            heapq.heappush(maxHeap, (-nums[right], right))
            heapq.heappush(minHeap, (nums[right], right))

            # 如果最大值 - 最小值 > limit，则移动左指针
            while -maxHeap[0][0] - minHeap[0][0] > limit:
                left += 1
                # 清理掉不在窗口范围内的堆顶元素
                while maxHeap[0][1] < left:
                    heapq.heappop(maxHeap)
                while minHeap[0][1] < left:
                    heapq.heappop(minHeap)

            # 更新结果
            result = max(result, right - left + 1)

        return result
```

O(N)
```python
class Solution:
    def longestSubarray(self, nums: List[int], limit: int) -> int:
        maxDeque = deque()
        minDeque = deque()
        left = 0
        result = 0

        for right in range(len(nums)):
            # 维护 maxDeque（单调递减）
            while maxDeque and nums[right] > maxDeque[-1]:
                maxDeque.pop()
            maxDeque.append(nums[right])

            # 维护 minDeque（单调递增）
            while minDeque and nums[right] < minDeque[-1]:
                minDeque.pop()
            minDeque.append(nums[right])

            # 如果窗口非法，收缩窗口
            while maxDeque[0] - minDeque[0] > limit:
                if maxDeque[0] == nums[left]:
                    maxDeque.popleft()
                if minDeque[0] == nums[left]:
                    minDeque.popleft()
                left += 1

            # 更新最大长度
            result = max(result, right - left + 1)

        return result

```
