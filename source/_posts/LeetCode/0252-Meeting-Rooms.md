---
title: 252-Meeting-Rooms
date: 2017-10-16 22:03:12
categories: LeetCode
tags:
---

题目描述：

Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), determine if a person could attend all meetings.

For example,
Given [[0, 30],[5, 10],[15, 20]],
return false.

```java
/**
 * Definition for an interval.
 * public class Interval {
 *     int start;
 *     int end;
 *     Interval() { start = 0; end = 0; }
 *     Interval(int s, int e) { start = s; end = e; }
 * }
 */
public class Solution {
    public boolean canAttendMeetings(Interval[] intervals) {
        if (intervals == null) return false; 
        
        Arrays.sort(intervals, new Comparator<Interval>() {
            
            public int compare(Interval o1, Interval o2) {
                return o1.start - o2.start;
            }
        });
        
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i].start < intervals[i-1].end) {
                return false;
            }
        }
        
        return true;
    }
}
```
