---
title: Python Heap
date: 2024-09-03 12:04:28
categories: Python
tags:
---

对于一个已有的数组，堆化，要调用 heapify

```python
import heapq

# Step 1: Create an initial list of numbers
numbers = [5, 7, 9, 1, 3]

# Step 2: Convert the list into a heap
heapq.heapify(numbers)
print("Heapified list:", numbers)

# Step 3: Perform heap operations
# Adding a new element to the heap
heapq.heappush(numbers, 4)
print("Heap after heappush(4):", numbers)

# Removing the smallest element from the heap
smallest = heapq.heappop(numbers)
print("Popped element:", smallest)
print("Heap after heappop:", numbers)

# Adding another new element to the heap
heapq.heappush(numbers, 2)
print("Heap after heappush(2):", numbers)

# Peek at the smallest element
smallest = numbers[0]
print("Smallest element:", smallest)
```

对于新建一个数组，不用调用 heapify 直接调用就行


```python
import heapq

# 创建一个空的堆
heap = []

# 逐个插入元素
elements = [5, 7, 9, 1, 3]
for element in elements:
    heapq.heappush(heap, element)

print("Heap after inserting elements:", heap)

# 继续使用堆操作
# 添加一个新元素
heapq.heappush(heap, 4)
print("Heap after heappush(4):", heap)

# 移除最小元素
smallest = heapq.heappop(heap)
print("Popped element:", smallest)
print("Heap after heappop:", heap)

# 添加另一个新元素
heapq.heappush(heap, 2)
print("Heap after heappush(2):", heap)

# 查看最小元素
smallest = heap[0]
print("Smallest element:", smallest)
```

