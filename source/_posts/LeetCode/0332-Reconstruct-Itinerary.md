---
title: 0332 Reconstruct Itinerary
date: 2017-12-26 06:21:26
categories: LeetCode
tags:
---

所有机场都能飞一遍，然后取字典序最小的

错误写法， 
```python
class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        graph = defaultdict(list)

        for start, end in tickets:
            heapq.heappush(graph[start], end)

        res = []
        
        def dfs(start):
            if not start:
                return None
            res.append(start)
            if len(graph[start]) > 0:
                next_node = heapq.heappop(graph[start])
                dfs(next_node)

        dfs("JFK")
        return res
```

这种写法只能遍历一个路径，没有探索所有可能性

错误写法2:
```python
class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        graph = defaultdict(list)

        for start, end in tickets:
            heapq.heappush(graph[start], end)

        res = []
        
        def dfs(start):
            res.append(start)
            while graph[start]:
                next_node = heapq.heappop(graph[start])
                dfs(next_node)

        dfs("JFK")
        return res
```

这个写法的 res.append(start) 是“前序遍历”，会导致：

在图中某条路径失败后，没有办法“回退”（回溯），因为你已经把节点添加到了最终结果中。

因为航班必须全部用完，你必须找到一个“欧拉路径”——遍历所有边一次，不能丢下航班。

当前的递归策略不是“边消耗完再添加到路径中”，这在欧拉路径构建中是关键点。

正确写法：后序插入，逆序输出
```python
class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        graph = defaultdict(list)

        for start, end in tickets:
            heapq.heappush(graph[start], end)

        res = []
        
        def dfs(start):
            
            while graph[start]:
                next_node = heapq.heappop(graph[start])
                dfs(next_node)
            res.append(start)

        dfs("JFK")
        return res[::-1]
```


