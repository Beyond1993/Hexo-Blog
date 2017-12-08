---
title: 区间问题
date: 2017-10-09 19:23:39
categories: LeetCode
tags:
---

区间问题的现实意义就是,工作中很多数据都是一段一段的。

区间合并问题,包括摩天大楼问题

一般都是interval, 排序，然后用

Priority Queue

TreeMap, TreeSet

排序 双指针


meeting-room 问题
https://leetcode.com/problems/meeting-rooms/description/
https://leetcode.com/problems/meeting-rooms-ii/description/

meeting rooms II
先按start 排序, 再将end 存入最小堆, 一旦上一个的end 比现在的start 大。就room +1

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

这样时间复杂度就是 O(nlogn)

这不是最优解，应该可以优化到O(n).

这也是常见的优化，用hashMap + index 去优化pq logn

```java
public class Solution {
    public int minMeetingRooms(Interval[] intervals) {
        int[] starts = new int[intervals.length];
        int[] ends = new int[intervals.length];
        for(int i=0; i<intervals.length; i++) {
            starts[i] = intervals[i].start;
            ends[i] = intervals[i].end;
        }
        Arrays.sort(starts);
        Arrays.sort(ends);
        int rooms = 0;
        int endsItr = 0;
        for(int i=0; i<starts.length; i++) {
            if(starts[i]<ends[endsItr])
                rooms++;
            else
                endsItr++;
        }
        return rooms;
    }
}
```

这题优化很trick, 这是一个

