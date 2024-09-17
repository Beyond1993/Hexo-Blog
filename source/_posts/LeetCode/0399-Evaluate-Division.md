---
title: 0399 Evaluate Division
date: 2017-12-26 06:22:02
categories: LeetCode
tags:
---


DFS

time O(e + e * q)
space O(e)

e is equations and q is queries


```python

class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        def divide(x, y, visited):
            if x == y: return 1.0
            visited.add(x)
            for n in g[x]:
                if n in visited: continue
                visited.add(n)
                d = divide(n, y, visited)
                if d > 0 : return d*g[x][n]
            return -1.0

        g = collections.defaultdict(dict)
        for (x, y), v in zip(equations, values):
            g[x][y] = v
            g[y][x] = 1.0 / v
        
        ans = [divide(x, y, set()) if x in g and y in g else -1 for x, y in queries]
        return ans
```


Union Find
```python
class Solution:
  def calcEquation(self, equations, values, queries):
    def find(x):
      if x != U[x][0]:
        px, pv = find(U[x][0])
        U[x] = (px, U[x][1] * pv)
      return U[x]
    
    def divide(x, y):
      rx, vx = find(x)
      ry, vy = find(y)
      if rx != ry: return -1.0
      return vx / vy
    
    U = {}
    for (x, y), v in zip(equations, values):      
      if x not in U and y not in U:
        U[x] = (y, v)
        U[y] = (y, 1.0)
      elif x not in U:
        U[x] = (y, v)
      elif y not in U:
        U[y] = (x, 1.0 / v)
      else:
        rx, vx = find(x)
        ry, vy = find(y)
        U[rx] = (ry, v / vx * vy)
    
    ans = [divide(x, y) if x in U and y in U else -1 for x, y in queries]
    return ans

```

这里Union Find
时间是 O(e + q)
空间是 O(e)

优于DFS


BFS
```python
def calcEquation(equations, values, queries):
	G = collections.defaultdict(dict)
	for (x, y), v in zip(equations, values):
		G[x][y] = v
		G[y][x] = 1/v
	def bfs(src, dst):
		if not (src in G and dst in G): return -1.0
		q, seen = [(src, 1.0)], set()
		for x, v in q:
			if x == dst: 
				return v
			seen.add(x)
			for y in G[x]:
				if y not in seen: 
					q.append((y, v*G[x][y]))
		return -1.0
	return [bfs(s, d) for s, d in queries]
```
