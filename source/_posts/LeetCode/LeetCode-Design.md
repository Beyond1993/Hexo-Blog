---
title: LeetCode-Design
date: 2017-08-24 00:43:07
categories: LeetCode
tags:
---
设计类题目包含了各种数据结构，算法，空间复杂度，优化等知识。在面试中已经成为必考题

通常用HashMap 空间换时间，降低时间复杂度, 比如linkedHashMap 实现 LRU

## 460 LFU Cache
主要就是Cache 的 get 和 set 方法，在evict 之前这段期间内使用频率最小的，使得每个操作的时间复杂度是O(1)

方案1. 双链表: 第一个节点存frequency 为 1 的keys, 第二个节点存frequency为2的节点
方案2. 在frequency 相同的情况下，根据lru，用到linkedHashMap / set
方案3. 用两个HashMap，一个 &lt; key, value &gt; 一个 &lt; key, node &gt;


