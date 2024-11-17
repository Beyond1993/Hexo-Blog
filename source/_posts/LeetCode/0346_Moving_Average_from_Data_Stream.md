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

queue, time O(size), 因为 [] pop(0)不是 O(1), 需要移动后面的元素

```python

class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.queue = []
        self.window_sum = 0
        self.count = 0

    def next(self, val: int) -> float:
        self.count += 1
        self.queue.append(val)
        tail = self.queue.pop(0) if self.count > self.size else 0
        self.window_sum = self.window_sum - tail + val

        return self.window_sum / min(self.size, self.count)
        
# Your MovingAverage object will be instantiated and called as such:
# obj = MovingAverage(size)
# param_1 = obj.next(val)
```

deque time O(1)
```python
class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.queue = deque()
        self.window_sum = 0
        self.count = 0

    def next(self, val: int) -> float:
        self.count += 1
        self.queue.append(val)
        tail = self.queue.popleft() if self.count > self.size else 0
        self.window_sum = self.window_sum - tail + val

        return self.window_sum / min(self.size, self.count)
        
# Your MovingAverage object will be instantiated and called as such:
# obj = MovingAverage(size)
# param_1 = obj.next(val)
```
