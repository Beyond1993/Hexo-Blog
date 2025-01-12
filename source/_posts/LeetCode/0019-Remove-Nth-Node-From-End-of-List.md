---
title: 0019 Remove Nth Node From End of List
date: 2017-12-29 23:46:52
categories: LeetCode
tags:
---


```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        ## 让first 先走 n 步
        ## 然后让first second 一起走，等first 到最后，second 就是倒数第n 个
        ## second.next = second.next.next 去掉第n 个
        dummy = ListNode(-1)
        dummy.next = head
        first, second = dummy, dummy

        for i in range(n + 1):
            first = first.next

        while first:
            first = first.next
            second = second.next
        second.next = second.next.next
        return dummy.next
```
