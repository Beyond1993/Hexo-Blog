---
title: 708. Insert into a Sorted Circular Linked List
date: 2024-06-03 06:54:56
categories: LeetCode
tags:
---

case1: Empty 

case2:

1-->2-->5, insert 4

case3: 

1-->2-->3, insert 4

case4:

3-->3-->3, insert 4


```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val=None, next=None):
        self.val = val
        self.next = next
"""

class Solution:
    def insert(self, head: 'Optional[Node]', insertVal: int) -> 'Node':
        ## case 1 empty
        if not head:
            node = Node(insertVal)
            node.next = node
            return node

        prev = head
        succ = head.next

        while True:
            ## case 2: 1-->2-->5, insert 4
            if prev.val <= insertVal and succ.val >= insertVal:
                break

            ## case 3: 1->2->3, insert 4
            if prev.val > succ.val:
                if (insertVal > prev.val or insertVal < succ.val):
                    break
            prev, succ = succ, succ.next
            
            ## case 4: 和head 做判断
            if prev == head:
                break


        node = Node(insertVal)
        nxt = prev.next
        prev.next = node
        node.next = nxt
        return head
```









