---
title: 0142 Linked List Cycle II
date: 2018-02-22 07:03:03
categories: LeetCode
tags:
---


Given a linked list, return the node where the cycle begins. If there is no cycle, return null.

Note: Do not modify the linked list.

Follow up:
Can you solve it without using extra space?


```text
head      start        meet  
|-----a-----|-----b-----|
            V           V
0 --> 1 --> 2 --> 3 --> 4 
            ^          /
             \        V       V
                --6-- 
            |-----c-----|
```

如果从表头到 环的 起始点 距离是 a, 环的起始点 到 相遇点的距离是 b, 相遇点到 环的起始点 距离是c.

这样 
慢指针走的路程是  distance1 = a + b
快指针走的路程是  distance2 = a + b + c + b
其中 distance1 * 2 = distance2, 快指针走的路程是慢指针的两倍。

(a + b) * 2 = a + b * 2 + c ==> a = c


            
