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

假设：

n 是等式数量（即 len(equations)）

q 是查询数量（即 len(queries)）

建图：O(n)

每个查询：最坏是 O(V + E) ≈ O(n)

总查询：q 个查询，总共是 O(q * n)

时间复杂度详解:

1. 建图的时间复杂度 O(E)
2. 每个查询调用一次 divide(x, y, visited) 的时间复杂度, 最坏情况 O(V + E), 
V 是图中的变量数量（nodes), E 是边的数量（equations 的数量 × 2，因为是双向边）
所以总的时间复杂度 O(E + (V+ E) * q)

3. 简化： 
边数 E = 2 * n，是等式数量 n 的线性函数。
变量数量 V 是所有出现在 equations 中的唯一字符串的数量，最多是 2n（每个等式涉及两个变量）。
但是通常远少于 2n。V <= 2*n

so: O(V + E) <= O(2n + 2n) = O(n)

final: O(E + (V+ E) * q) = O(e + e * q)

```python

class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        def divide(x, y, visited):
            if x == y: return 1.0
            visited.add(x)
            for n in g[x]:
                if n in visited: continue
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
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        # parent 记录每个变量的父节点和到父节点的除法比值
        # 形式为 parent[x] = (父节点, x / 父节点)
        parent = {}

        def find(x: str):
            """
            查找变量 x 的根节点，并计算 x 到根节点的乘积比值。
            同时进行路径压缩，将 x 直接连接到根节点。
            返回：根节点、x 到根的比值
            """
            if x != parent[x][0]:
                orig_parent, value_to_parent = parent[x]
                root, value_to_root = find(orig_parent)
                # parent, root, 都是在分母的位置，x / y = a, y / root = b ==> x/root = x/y * y/root = a * b
                # 路径压缩，并更新 x 到根的比值
                parent[x] = (root, value_to_parent * value_to_root)
            return parent[x]

        def divide(x: str, y: str) -> float:
            """
            查询 x / y 的值。如果不在同一集合，返回 -1.0；
            否则通过 x/root 和 y/root 的比值计算 x/y。
            """
            root_x, ratio_x = find(x)
            root_y, ratio_y = find(y)
            if root_x != root_y:
                return -1.0
            return ratio_x / ratio_y

        # 构建并查集
        for (a, b), value in zip(equations, values):
            if a not in parent and b not in parent:
                # 两个变量都不在集合中，初始化
                parent[a] = (b, value)       # a / b = value
                parent[b] = (b, 1.0)         # b / b = 1.0
            elif a not in parent:
                # 只有 a 不在，接到 b 上
                parent[a] = (b, value)       # a / b = value
            elif b not in parent:
                # 只有 b 不在，接到 a 上
                parent[b] = (a, 1.0 / value) # b / a = 1/value
            else:
                # 两个都存在，合并两个集合
                # ratio_a = a / root_a
                root_a, ratio_a = find(a)
                # ratio_b = b / root_b
                root_b, ratio_b = find(b)
                
                # 将 a 的根节点root_a 连接到 b 的根节点 root_b，调整比值, 即算出 root_a / root_b = ?
                # 已知: a / b = value, a / root_a = ratio_a, b / root_b = ration_b
                # 求: root_a / root_b = ?
                # 解: root_a / root_b = (a / ration_a ) / (b / ration_b) 
                #     = [(a / ration_a) * (ratio_b / b)] / [(b / ration_b) * (ratio_b / b)]
                #     = (a / ration_a) * (ratio_b / b) = ( a * ratio_b) / (b * ratio_a) = (a / b) * (ratio_b / ratio_a)
                #     = value * (ratio_b / ratio_a) = value * ratio_b / ratio_a
            
                parent[root_a] = (root_b, value * ratio_b / ratio_a)

        # 处理查询
        results = []
        for x, y in queries:
            if x in parent and y in parent:
                results.append(divide(x, y))
            else:
                results.append(-1.0)
        return results

```

这里Union Find
时间是 O(e + q)
空间是 O(e)

优于DFS


![](/images/lc_399.png)


BFS 和 DFS 时间复杂度  一样
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
