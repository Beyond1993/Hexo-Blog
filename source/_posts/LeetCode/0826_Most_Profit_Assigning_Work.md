---
title: 0826 Most Profit Assigning Work
date: 2025-02-11 06:51:55
categories: LeetCode
tags:
---


这题就是贪心法，将job 按难度和利润排序，再将工人按能力排序

然后给每个工人分配能力范围内最大的工作，更新profit, 由于并不是难度越大，profit 越高，所以记录一个
max_profit

```python
from typing import List

class Solution:
    def maxProfitAssignment(self, difficulty: List[int], profit: List[int], worker: List[int]) -> int:
        # 将工作按难度和利润组合成一个元组，并按难度排序
        jobs = sorted(zip(difficulty, profit))
        
        # 对工人按能力排序
        worker.sort()
        
        # 初始化当前工作最大利润
        max_profit = 0
        job_idx = 0
        total_profit = 0
        
        # 对每个工人分配工作
        for ability in worker:
            # 找到工人能做的最大难度的工作，并更新最大利润
            while job_idx < len(jobs) and jobs[job_idx][0] <= ability:
                max_profit = max(max_profit, jobs[job_idx][1])
                job_idx += 1
            # 累加当前工人能获得的最大利润
            total_profit += max_profit
        
        return total_profit
```
