---
title: Amazon-SDE-II-OA
date: 2024-06-23 05:19:19
categories: Interview
tags:
---

Maximum Stability

The client defines the stability of a set of servers as the minimum availability amongst the servers multiplied by the sum of reliabilities of all the servers. Given two arrays of integers, availability, and reliability, where the availability[i] and reliability[i] represent the availability and reliability factors of the i^th server, find the maximum possible stability of any subset of servers.
Since the answer can be large, report the answer modulo (10^9 + 7).
Function Description
Complete the function maximumStability in the editor.
maximumStability has the following parameters:
* 		1. int reliability[n]: an array of integers
* 		2. int availability[n]: an array of integers

Returns
int: the maximum stability above among all possible non-empty subsets, modulo (10^9+7)


```python
def maximum_stability2(reliability, availability):
    container = []
    n = len(reliability)
    for i in range(n):
        container.append([reliability[i], availability[i]])
    container.sort(key=lambda x: (-x[1], -x[0]))
    mod = pow(10, 9) + 7

    for c in container:
        print(f"[{c[0]}, {c[1]}], ", end="")
    
    cur_relia = container[0][0]
    cur_avail = container[0][1]
    max_sta = cur_relia * cur_avail
    for i in range(1, n):
        cur_relia += container[i][0]
        cur_avail = container[i][1]
        max_sta = max(max_sta, cur_relia * cur_avail)
    
    return max_sta
 
print(maximum_stability2([1,6,6], [1,2,3]))
```


findRequestsInQueue
https://www.fastprep.io/problems/amazon-find-requests-in-queue
maxSetSize(Rice bags):
https://www.fastprep.io/problems/max-set-size

https://leetcode.com/discuss/interview-question/5243021/Amazon-OA-Assessment-(Feb-2024)/


getMaxTotalArea:
despcibtion: https://www.fastprep.io/problems/amazon-get-max-total-area
solution: https://leetcode.com/discuss/interview-question/4908388/OA-Question/

find minimum number of pages:
https://www.fastprep.io/problems/find-minimum-pages-per-day

