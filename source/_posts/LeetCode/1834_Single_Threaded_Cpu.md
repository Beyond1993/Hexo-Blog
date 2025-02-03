---
title: 1834 Single Threaded Cpu
date: 2025-02-03 14:25:47
categories: LeetCode
tags:
---

```python
import heapq
from typing import List, Tuple

class Solution:
    def getOrder(self, tasks: List[List[int]]) -> List[int]:
        # 最小堆，存储 (处理时间, 原始索引)
        next_task: List[Tuple[int, int]] = []
        tasks_processing_order: List[int] = []
        
        # 存储 (任务进入时间, 处理时间, 索引)
        sorted_tasks = [(enqueue, process, idx) for idx, (enqueue, process) in enumerate(tasks)]
        sorted_tasks.sort()  # 按进入时间排序
        
        curr_time = 0
        task_index = 0
        
        # 当任务数组和最小堆都为空时，结束循环
        while task_index < len(tasks) or next_task:
            # case1: 第一个任务的时间还没到，sorted_tasks[task_index][0] > curr_time 
            if not next_task and curr_time < sorted_tasks[task_index][0]:
                # 没有可执行的任务时，将当前时间跳到下一个任务的进入时间
                curr_time = sorted_tasks[task_index][0]
            
            # case2: 有好几个任务已经大于等于当前时间，等着去执行 sorted_tasks[task_index][0] <= curr_time
            # 将所有入队时间 <= 当前时间的任务加入堆
            while task_index < len(sorted_tasks) and curr_time >= sorted_tasks[task_index][0]:
                _, process_time, original_index = sorted_tasks[task_index]
                heapq.heappush(next_task, (process_time, original_index))
                task_index += 1
            
            # 取出堆顶任务（最短处理时间 -> 原始索引最小）
            process_time, index = heapq.heappop(next_task)
            
            # 处理任务并更新时间
            curr_time += process_time
            tasks_processing_order.append(index)
        
        return tasks_processing_order
```


