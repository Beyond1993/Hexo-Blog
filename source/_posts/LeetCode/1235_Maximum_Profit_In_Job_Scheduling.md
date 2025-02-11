---
title: 1235 Maximum Profit In Job Scheduling
date: 2025-01-28 14:04:47
categories: LeetCode
tags:
---

问题的描述是：给定一组工作，每个工作都有一个开始时间、结束时间和利润。要求选择一些不重叠的工作，使得总利润最大化。

思路: 贪心 加 动态规划 加 二分搜索

先按照 开始时间，结束时间，利润 排序，然后分两种情况：
case1: 运行当前job, dfs
case2: 不运行当前job, dfs

用二分法，找到当前job 结束后，next start_time >= cur end_time 的job 作为候选

python 自带的bisect, 有三种写法, 
bisect(), bisect_right() 都是要找到严格大于当前数字的，
bisect_left() 找到大于等于当前数字的.

第一种写法里 因为排序的是 (jobs([i][1], -1,-1), end profit 不可能找到-1, 所以一定不等

```python
from typing import List

class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
       

        # 将所有工作整理成 (start, end, profit) 的列表并按开始时间排序
        jobs = sorted(zip(startTime, endTime, profit))
        
        cache = {}

        def dfs(i):
            if i == len(jobs):
                return 0
            if i in cache:
                return cache[i]

            res = dfs(i + 1)

            j = bisect.bisect_right(jobs, (jobs[i][1], -1, -1))
            cache[i] = res = max(res, jobs[i][2] + dfs(j))
            return res
        return dfs(0)
```

```python
from typing import List

class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
       

        # 将所有工作整理成 (start, end, profit) 的列表并按开始时间排序
        jobs = sorted(zip(startTime, endTime, profit))
        
        cache = {}

        def dfs(i):
            if i == len(jobs):
                return 0
            if i in cache:
                return cache[i]

            res = dfs(i + 1)

            j = bisect.bisect(jobs, (jobs[i][1], -1, -1))
            cache[i] = res = max(res, jobs[i][2] + dfs(j))
            return res
        return dfs(0)
```


```python
from typing import List

class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:

        # 将所有工作整理成 (start, end, profit) 的列表并按开始时间排序
        jobs = sorted(zip(startTime, endTime, profit))
        startTime = [job[0] for job in jobs]  # 提取排序后的开始时间列表
        n = len(jobs)

        # 记忆化数组，初始值为 -1
        memo = [-1] * n

        def find_max_profit(position: int) -> int:
            if position == n:  # 所有工作都处理完
                return 0

            if memo[position] != -1:  # 如果已经计算过，直接返回
                return memo[position]

            # 找到下一个不冲突工作的索引
            nextIndex = bisect.bisect_left(startTime, jobs[position][1])

            # 跳过当前工作或选择当前工作的最大利润
            memo[position] = max(
                find_max_profit(position + 1),  # 跳过当前工作
                jobs[position][2] + find_max_profit(nextIndex)  # 选择当前工作
            )

            return memo[position]

        return find_max_profit(0)
```
