---
title: 0986 Interval List Intersections
date: 2024-12-16 09:40:54
categories: LeetCode
tags:
---


最基本的思路，分成6个case

```python
class Solution:
    def intervalIntersection(self, firstList: List[List[int]], secondList: List[List[int]]) -> List[List[int]]:
        
        i, j = 0, 0
        res = []

        while i < len(firstList) and j < len(secondList):
            start1, end1 = firstList[i][0], firstList[i][1]
            start2, end2 = secondList[j][0], secondList[j][1]

            # case1: fist: [3,4] second : [0,2]
            if start1 > end2:
                j += 1
                #print("1")
            # case2: [[0,2] [3,4]
            elif end1 < start2:
                i += 1
                #print("2")
            # case3: [3,7], [1,5]
            elif start1 <= end2 and start1 >= start2 and end1 > end2:
                res.append([start1, end2])
                j += 1
                #print("3")
            # case4: [3,5], [2, 6]    
            elif start1 >= start2 and end1 <= end2:
                res.append([start1, end1])
                i += 1
                #print("4")
            # case5: [1, 5], [3, 7]
            elif end1 >= start2 and start1 < start2 and end1 <= end2:
                res.append([start2, end1])
                i += 1
                #print("5")
            #case6: [2,6], [3,5]    
            elif start1 <= start2 and end1 >= end2:
                res.append([start2, end2])
                j += 1
                #print("6")
        return res
```


best 
```python
class Solution:
    def intervalIntersection(self, firstList: List[List[int]], secondList: List[List[int]]) -> List[List[int]]:
        res = []
        i, j = 0, 0

        while i < len(firstList) and j < len(secondList):
            left = max(firstList[i][0], secondList[j][0])
            right = min(firstList[i][1], secondList[j][1])

            if left <= right:
                res.append([left, right])
            ## if start > end, ignore
            # Remove the interval with the smallest endpoint
            if firstList[i][1] < secondList[j][1]:
                i += 1
            else:
                j += 1
        
        return res
```


