---
title: CMU-15640-3-File-Caching-Proxy
date: 2017-08-20 08:03:01
categories: CMU课程
tags: cmu
---
# Project 3 File Caching Proxy

References number of attempts to find an object in the cache Hits number of successes
Misses number of failures
Miss Ratio = Misses/References
Hit Ratio = Hits/References = (1 − Miss Ratio)
Expected cost of a reference = (Miss Ratio * cost of miss) + (Hit Ratio * cost of hit)
Cache Advantage = (Cost of Miss / Cost of Hit)
(where cost is measured in time delay to access object)

1. Whatdatashouldyoucacheandwhen?
Fetch Policy
2. How do updates become visible everywhere?
Update propagation policy
3. Whatolddatadoyouthrowouttofreeupspace?
Cache replacement policy

传统分布式cache
```text
machine1     machine2
       \     /
       product
       /     \
machineN     machine3
```
sync solution's shortcomings

1. Storage for entry on every replica

2. Significant update traffic on hot spots

3. Machines receive updates whether they care or not

A Much Better Approach

on-demanding caching: Transparently fetch file only if needed.

Update Propagation (Cache Consistency)

it is hard to keep cache cnosistent.

one-copy semantics

保持强一致性的方法。

1. Broadcast Invalidations

2. Check on Use

3. Callback

4. Lease Renewal

5. Skip Scary Parts

6. Faith-based Caching

7. Pass the Buck

Google-File-System:

Lustre-File-System:

## Project
Writeup:
这个项目是基于第一个项目remote call file system 的，在第一个项目的基础上加上proxy-cache

在分布式系统中，Hash + Cache 基本就是大杀器。




