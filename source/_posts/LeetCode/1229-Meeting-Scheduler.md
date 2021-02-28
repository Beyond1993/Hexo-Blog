---
title: 1229 Meeting Scheduler
date: 2021-03-01 00:31:12
categories: LeetCode
tags:
---


Given the availability time slots arrays slots1 and slots2 of two people and a meeting duration duration, return the earliest time slot that works for both of them and is of duration duration.

If there is no common time slot that satisfies the requirements, return an empty array.

The format of a time slot is an array of two elements [start, end] representing an inclusive time range from start to end.

It is guaranteed that no two availability slots of the same person intersect with each other. That is, for any two time slots [start1, end1] and [start2, end2] of the same person, either start1 > end2 or start2 > end1.

 

Example 1:

Input: slots1 = [[10,50],[60,120],[140,210]], slots2 = [[0,15],[60,70]], duration = 8
Output: [60,68]
Example 2:

Input: slots1 = [[10,50],[60,120],[140,210]], slots2 = [[0,15],[60,70]], duration = 12
Output: []


```java
class Solution {
public List<Integer> minAvailableDuration(int[][] slots1, int[][] slots2, int duration) {
    
    
    List<Integer> res = new ArrayList<>();
    
    int index1 = 0;
    
    int index2 = 0;
    
    
    Arrays.sort(slots1, (a,b) -> (a[0] - b[0]));
    
    Arrays.sort(slots2, (a,b) -> (a[0] - b[0]));
    
    while(index1 < slots1.length && index2 < slots2.length){
        
        
        boolean flag = Math.max(slots1[index1][0],slots2[index2][0]) <= Math.min(slots1[index1][1],slots2[index2][1]);
        
        if(flag){
            
            int[] newInterval = new int[]{Math.max(slots1[index1][0],slots2[index2][0]),
                      Math.min(slots1[index1][1],slots2[index2][1])};
            
            int mergeDuration = (newInterval[1] - newInterval[0]);
             
            if(mergeDuration >= duration){
                
                res.add(newInterval[0]);
                
                res.add(newInterval[0]+duration);
                
                return res;
                
            }
        }
        
        if(slots1[index1][1] > slots2[index2][1]){
            
            index2++;
        }
        else index1++;
    }
    
    return res;
    
    }

}
```
