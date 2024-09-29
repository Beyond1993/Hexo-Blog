---
title: 0215 Kth Largest Element in an Array
date: 2018-01-15 00:37:32
categories: LeetCode
tags:
---

Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.
For example,
Given [3,2,1,5,6,4] and k = 2, return 5.

Note: 
You may assume k is always valid, 1 ≤ k ≤ array's length.

Credits:
Special thanks to @mithmatt for adding this problem and creating all test cases.

这题用priority queue.

一开始想法是把所有的数先存到最小堆里面，然后poll k 次。这样这个堆的 size 就是 n.

但是现在是维护一个size 为 k 的最小堆, 这样去除里 n - k 个 最小的元素, heap 里面保留里 K 个最大的值, 但这又是最小堆，所以堆顶元素是 K 个最大的里面最小的.


```python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        ## 维护一个size 为 k 的最小堆
        heap = []
        for num in nums:
            heapq.heappush(heap, num)
            if len(heap) > k:
                heapq.heappop(heap)
        return heap[0]
        
```
