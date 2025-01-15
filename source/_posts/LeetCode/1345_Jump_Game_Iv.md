---
title: 1345 Jump Game IV
date: 2025-01-14 11:29:16
categories: LeetCode
tags:
---

BFS

Bi-BFS

```python
class Solution:
    def minJumps(self, arr) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        graph = {}
        for i in range(n):
            if arr[i] in graph:
                graph[arr[i]].append(i)
            else:
                graph[arr[i]] = [i]

        curs = set([0])  # 当前层节点，从起点出发
        other = set([n - 1])  # 当前层节点，从终点出发
        visited = {0, n - 1}  # 已访问的节点
        step = 0

        while curs:
            # 始终从节点数较少的一侧扩展
            if len(curs) > len(other):
                curs, other = other, curs
            nex = set()

            for node in curs:
                # 遍历相同值的索引和相邻索引
                for child in graph[arr[node]] + [node - 1, node + 1]:
                    if child in other:  # 如果当前节点在另一端集合中，返回步数
                        return step + 1
                    if 0 <= child < n and child not in visited:  # 合法且未访问
                        visited.add(child)
                        nex.add(child)

                # 清空相同值的索引，避免重复搜索
                graph[arr[node]].clear()

            curs = nex  # 更新当前层节点
            step += 1

        return -1
```
