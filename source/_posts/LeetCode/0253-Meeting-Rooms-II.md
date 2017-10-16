---
title: 0253-Meeting-Rooms-II
date: 2017-10-09 19:19:14
categories:
tags:
---

题目描述:
Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of conference rooms required.

For example,
Given [[0, 30],[5, 10],[15, 20]],
return 2.

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
    public int minMeetingRooms(Interval[] intervals) {  
        Arrays.sort(intervals, new IntervalComparator());  
        PriorityQueue<Integer> minHeap = new PriorityQueue();  
        int rooms = 0;  
        for(int i = 0; i < intervals.length; i++) {  
            if(minHeap.size() == 0) {  
                minHeap.add(intervals[i].end);  
                rooms++;  
                continue;  
            }  
            if(minHeap.peek() <= intervals[i].start) {  
                minHeap.poll();  
                minHeap.add(intervals[i].end);  
            } else {  
                minHeap.add(intervals[i].end);  
                rooms++;  
            }  
        }  
        return rooms;  
    }  
}  
  
class IntervalComparator implements Comparator<Interval> {  
    public int compare(Interval a, Interval b) {  
        return a.start - b.start;  
    }  
} 
```

