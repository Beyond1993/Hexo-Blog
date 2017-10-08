---
title: 340-Longest-Substring-with-At-Most-K-Distinct-Characters
date: 2017-10-04 03:31:12
categories: LeetCode
tags:
---

这题用subline windows 的模版做。

follow up 难就难在，不能用 priority queue. 
其实想要实现的是，按照value 排好序的HashMap, 这样每次都可以拿出最小值，其实就是heap hashmap的结合，但是并不好实现，因为如果将entry 作为一个对象存入 heap, 解决不了update的问题。
如果将整个hashMap 作为对象。做不到排序。

如果用linkedHashMap，只能做到按照put进map的顺序来显示，除非每次都sort。

既然linkedHashMap 自然而然就想到了双链表。

重点来了，链表和HashMap 之间的关系!!! 在此之前，这一环是缺失的

双链表加HashMap 使得get set的时间复杂度降到O(1)
