---
title: 0138 Copy List with Random Pointer
date: 2017-12-26 06:54:14
categories: LeetCode
tags:
---


```python
"""
# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random
"""

class Solution:   
    
    def __init__(self):
        self.visitedMap = {}

    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        
        if not head:
            return head
        
        if self.visitedMap and head in self.visitedMap:
            return self.visitedMap.get(head)
        
        newNode = Node(head.val, None, None)
        self.visitedMap[head] = newNode

        newNode.next = self.copyRandomList(head.next)
        newNode.random = self.copyRandomList(head.random)

        return newNode
```
