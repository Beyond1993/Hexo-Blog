---
title: Interview-DoorDash-Shortest-Distance-of-DashMart
date: 2025-02-20 14:23:16
categories: Interview
tags: DoorDash
---

24年冬季的电面，网投Target E6，电面遇到国人。然而出了一道BFS的DD变种，写完能跑过大部分Test case，个别corner case卡主了，遂挂。
LC题号 伞妖漆
变种如下:
building变成了DashMart，是在一个点起步，到所有DashMart的距离总和最小。condidtion 有变化，obstacle 和DashMart都可以作为起点，但是obstacle 不能通过，DashMart可以通过。Test case中包括DashMart被obstacle隔开的情况。。。


```python
from collections import deque

def find_min_total_distance(matrix):
    if not matrix or not matrix[0]:
        return -1
    
    rows, cols = len(matrix), len(matrix[0])
    buildings = []
    candidates = []
    
    # 记录所有 Building 的位置和候选起点
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 1:
                buildings.append((i, j))
                candidates.append((i, j))  # Building 可以作为起点
            elif matrix[i][j] == 0:
                candidates.append((i, j))  # 空地可以作为起点
    
    min_total_distance = float('inf')
    best_start = None
    
    # 对于每个候选起点
    for start in candidates:
        total_distance = 0
        distance = [[float('inf')] * cols for _ in range(rows)]
        queue = deque()
        
        # 初始化起点
        start_i, start_j = start
        distance[start_i][start_j] = 0
        queue.append((start_i, start_j))
        
        # BFS
        while queue:
            i, j = queue.popleft()
            current_dist = distance[i][j]
            
            # 遍历四个方向
            for di, dj in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                ni, nj = i + di, j + dj
                if 0 <= ni < rows and 0 <= nj < cols:
                    if matrix[ni][nj] != 2 and distance[ni][nj] == float('inf'):
                        distance[ni][nj] = current_dist + 1
                        queue.append((ni, nj))
        
        # 计算总距离
        for building in buildings:
            building_i, building_j = building
            if distance[building_i][building_j] == float('inf'):
                # 如果某个 Building 不可达，则该起点无效
                total_distance = float('inf')
                break
            total_distance += distance[building_i][building_j]
        
        # 更新最小总距离
        if total_distance < min_total_distance:
            min_total_distance = total_distance
            best_start = start
    
    if min_total_distance == float('inf'):
        return -1  # 没有有效的起点
    else:
        return best_start, min_total_distance

# 测试用例
case1 = [
    [0, 1, 0, 0],
    [0, 0, 0, 1],
    [0, 2, 0, 0]
]

result = find_min_total_distance(case1)
print("最佳起点和最小总距离:", result)

case2 = [
    [0, 2, 0],
    [1, 2, 1],
    [0, 0, 0]
]
result = find_min_total_distance(case2)
print("最佳起点和最小总距离:", result)

case3 = [
    [1, 0, 1],
    [0, 2, 0],
    [0, 0, 0]
]
result = find_min_total_distance(case3)
print("最佳起点和最小总距离:", result)

case4 = [
    [1, 0, 1],
    [0, 0, 0],
    [2, 0, 2]
]
result = find_min_total_distance(case4)
print("最佳起点和最小总距离:", result)

# 测试用例
case5 = [
    [1, 0, 0, 2, 1],
    [0, 2, 0, 0, 0],
    [0, 0, 2, 0, 1],
    [2, 0, 0, 0, 0],
    [1, 0, 2, 0, 1]
]
result = find_min_total_distance(case5)
print("最佳起点和最小总距离:", result)

case6 = [
    [0, 1, 0],
    [0, 0, 0],
    [0, 2, 2]
]

result = find_min_total_distance(case6)
print("最佳起点和最小总距离:", result)

# 测试用例
case7 = [
    [1, 0, 0, 2, 1],
    [0, 1, 2, 0, 0],
    [0, 2, 1, 2, 1],
    [2, 0, 2, 0, 0],
    [1, 0, 0, 0, 1]
]


result = find_min_total_distance(case7)
print("最佳起点和最小总距离:", result)
```
