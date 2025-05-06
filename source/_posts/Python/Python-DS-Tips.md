---
title: Python-DS-Tips
date: 2025-05-06 08:23:46
categories: Python
tags:
---

# Python Advanced Data Structures Tips (LeetCode)

## 1. Heap (min/max)
```python
import heapq

# Min-heap
h = []
heapq.heappush(h, val)
heapq.heappop(h)

# Max-heap (store -val)
heapq.heappush(h, -val)
-val = heapq.heappop(h)

# Custom tuple sort: (priority, data)
heapq.heappush(h, (priority, obj))
```
- heapq 只支持最小堆，自定义比较时用 tuple 或自定义类的 __lt__

## 2. `__lt__` for Custom Objects in Heap or Sort
```python
class Node:
    def __init__(self, val, freq):
        self.val, self.freq = val, freq

    def __lt__(self, other):
        return self.freq < other.freq  # min-heap by freq
```

## 3. Lambda Sort
```python
# Single key
sorted(arr, key=lambda x: x[1])

# Multiple keys (descending then ascending)
arr.sort(key=lambda x: (-x[0], x[1]))

# Sort Node List
nodes = [Node('A', 5), Node('B', 2), Node('C', 8)]
sorted_nodes = sorted(nodes)

```

## 4. `sorted()` vs `list.sort()`
- `sorted()` returns a new list.
- `list.sort()` modifies in-place.

## 5. `collections` Utilities
```python
from collections import defaultdict, Counter, deque

# defaultdict
graph = defaultdict(list)
graph[u].append(v)

# Counter
c = Counter("abracadabra")
c.most_common(2)  # [('a', 5), ('b', 2)]

# deque for O(1) pops from both ends
q = deque()
q.appendleft(1)
q.append(2)
q.popleft()
```
- `deque` is ideal for sliding window problems

## 6. `bisect` for Binary Search
```python
from bisect import bisect_left, bisect_right, insort

arr = [1, 2, 4, 4, 5]
bisect_left(arr, 4)   # 2 (first index of 4)
bisect_right(arr, 4)  # 4 (first index > 4)

# Insert while maintaining sorted order
insort(arr, 3)        # arr becomes [1,2,3,4,4,5]
```
- Use `bisect_right` for upper bound, `bisect_left` for lower bound

## 7. `SortedContainers` (third-party)
```python
from sortedcontainers import SortedList, SortedDict

s = SortedList()
s.add(10)
s.add(5)
s.add(8)
s  # SortedList([5, 8, 10])

s.bisect_left(8)   # 1
s.bisect_right(8)  # 2
s.pop(0)           # 5

# SortedDict: like TreeMap in Java
from sortedcontainers import SortedDict
sd = SortedDict()
sd[10] = 'a'
sd[5] = 'b'
list(sd.items())  # [(5, 'b'), (10, 'a')]
```
- SortedList supports fast insert/search with `O(log n)` performance

## 8. Trie (Prefix Tree)
```python
class Trie:
    def __init__(self):
        self.root = {}

    def insert(self, word):
        node = self.root
        for ch in word:
            node = node.setdefault(ch, {})
        node['$'] = True

    def search(self, word):
        node = self.root
        for ch in word:
            if ch not in node:
                return False
            node = node[ch]
        return '$' in node
```
- Use for prefix lookups, autocomplete, or word games

## 9. Union-Find (Disjoint Set)
```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        self.parent[py] = px
        return True
```
- Apply in Kruskal's MST, connected components, etc.

