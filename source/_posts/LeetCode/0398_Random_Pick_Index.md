---
title: 0398 Random Pick Index
date: 2025-01-07 09:37:23
categories: LeetCode
tags:
---


注意把这题和 528 Random Pick with Weight 区别开来
http://47.113.101.198/2019/10/13/LeetCode/0528-Random-Pick-with-Weight/



这题是返回 index, 比如 [1, 2, 3, 3, 3] pick 3, 有可能 返回index, 2, 3, 4,概率均等

528 是 给每个index 一个权重，然后按这个weight  的概率返回 相对应的index

所以这题是水塘抽样 528 是 pre_sum + 二分


最直观的解法

就是给不同的value 简历一个 map {value, indices}

取到那个value,就从这个value 对应的indices 里找一个index

```python
class Solution:

    def __init__(self, nums: List[int]):
        self.indices = defaultdict(list)
        for i, num in enumerate(nums):
            self.indices[num].append(i)

    def pick(self, target: int) -> int:
        return random.choice(self.indices[target])
```

pick time O(1), space O(N)


水塘抽样:

```python
class Solution:

    def __init__(self, nums: List[int]):
        self.nums = nums

    def pick(self, target: int) -> int:
        count, idx = 0, 0
        for i in range(len(self.nums)):
            if self.nums[i] == target:
                count += 1
                if random.randint(1, count) == 1:
                    idx = i
        return idx

# Your Solution object will be instantiated and called as such:
# obj = Solution(nums)
# param_1 = obj.pick(target)
```

这个的pick time 是 O(N)

水塘抽样算法主要是运用在不知道list length 的stream 里，
可以改成
```python
class Solution:

    def __init__(self, nums: List[int]):
        self.nums = nums

    def pick(self, target: int) -> int:
        count, idx = 0, 0
        i = 0
	while stream.hasNext():
            if stream.next() == target:
                count += 1
                if random.randint(1, count) == 1:
                    idx = i
	    i += 1
        return idx

# Your Solution object will be instantiated and called as such:
# obj = Solution(nums)
# param_1 = obj.pick(target)
```
