---
title: 1570 Dot Product Of Two Sparse Vectors
date: 2024-12-27 08:41:52
categories: LeetCode
tags:
---
Hash Map to save only non-zero values:

```python
class SparseVector:
    def __init__(self, nums: List[int]):
        self.map = {}
        for i in range(len(nums)):
            if nums[i] != 0:
                self.map[i] = nums[i] 
        

    # Return the dotProduct of two sparse vectors
    def dotProduct(self, vec: 'SparseVector') -> int:
        res = 0
        for i, v in self.map.items():
            if i in vec.map:
                res += v * vec.map[i]
        return res

# Your SparseVector object will be instantiated and called as such:
# v1 = SparseVector(nums1)
# v2 = SparseVector(nums2)
# ans = v1.dotProduct(v2)
```

Index-Value Pairs

```python
class SparseVector:
    def __init__(self, nums: List[int]):
        self.pairs = []
        for index, value in enumerate(nums):
            if value != 0:
                self.pairs.append([index, value])

    def dotProduct(self, vec: 'SparseVector') -> int:
        result = 0
        p, q = 0, 0

        while p < len(self.pairs) and q < len(vec.pairs):
            if self.pairs[p][0] == vec.pairs[q][0]:
                result += self.pairs[p][1] * vec.pairs[q][1]
                p += 1
                q += 1
            elif self.pairs[p][0] < vec.pairs[q][0]:
                p += 1
            else:
                q += 1

        return result
```

