---
title: 0210 Course Schedule II
date: 2017-12-26 06:17:22
categories: LeetCode
tags:
---

DFS 写法, 在visited 数组上

```python
class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        graph = [[] for _ in range(numCourses)]

        for preq in prerequisites:
            graph[preq[1]].append(preq[0])
        
        print(graph)

        visited = [False] * numCourses
        checked = [False] * numCourses
        res = []
        def dfs(course, visited, checked, res):
            print(course)
            if checked[course]:
                return True
            if visited[course]:
                return False

            visited[course] = True
            
            for neighbor in graph[course]:
                if not dfs(neighbor, visited, checked, res):
                    return False

            visited[course] = False
            checked[course] = True
            res.append(course)
            print(res)

        for course in range(numCourses):
            if not visited[course]:
                if not dfs(course, visited, checked, res):
                    return []
        return res
```
