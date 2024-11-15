---
title: page
date: 2024-11-15 13:18:00
categories: LeetCode
tags:
---

这是我写的第一版最直观的版本， 只打败了5%

```python
class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.nums = [None] * size
        self.index = 0

    def next(self, val: int) -> float:

        if not self.nums[self.index]:
            self.nums[self.index] = val
            self.index = (self.index + 1) % self.size
            nums_sum = 0
            n = 0
            for i in range(self.size):
                if self.nums[i]:
                    nums_sum += self.nums[i]
                    n += 1.0
            return nums_sum / n
        else:
            self.nums[self.index] = val
            self.index = (self.index + 1) % self.size
            return sum(self.nums) / self.size
```
