---
title: 0253-Meeting-Rooms-II
date: 2017-10-16 22:05:30
categories: LeetCode
tags:
---

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

这个思路应该是最优解.很多时候，O(nlogn) 不是最优解。 要优化到O(n) 才行，

用roomNums 记录每个interval 对应的房间的位置，如果当前的start > end, 则表示可以使用上一个interval的房间
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
    
        if (intervals == null || intervals.length == 0) {
            return 0;
        }
        Element[] starts = new Element[intervals.length];
        Element[] ends = new Element[intervals.length];
        for (int i = 0; i < intervals.length; i++) {
            starts[i] = new Element(intervals[i].start, i);
            ends[i] = new Element(intervals[i].end, i);
        }
        Arrays.sort(starts);
        Arrays.sort(ends);
        int rooms = 0;
        int endIndex = 0;
        // roomNums[i] is intervals[i]'s room number
        int[] roomNums = new int[intervals.length];
        // interval 0 1 2 3
        //  room    0 1 0 2 
        for (int startIndex = 0; startIndex < starts.length; startIndex++) {
            int currentIndex = starts[startIndex].index;
            if (starts[startIndex].compareTo(ends[endIndex]) < 0) {
                roomNums[currentIndex] = rooms++;
            } else {
                roomNums[currentIndex] = roomNums[ends[endIndex++].index];
            }
        }
        Map<Integer, List<Interval>> m = new HashMap<>(rooms);
        for (int i = 0; i < intervals.length; i++) {
            System.out.println(intervals[i] + " room " + roomNums[i]);
            m.computeIfAbsent(roomNums[i], k -> new ArrayList<>()).add(intervals[i]);
        }
        for (int i = 0; i < rooms; i++) {
            System.out.println("Room " + i + " " + m.get(i));
        }
        return rooms;    
    }  
    class Element implements Comparable<Element> {
        int val;
        int index;

        public Element(int v, int i) {
            this.val = v;
            this.index = i;
        }

        public int compareTo(Element other) {
            return Integer.compare(this.val, other.val);
        }

        public int getIndex() {
            return this.index;
        }

        public int getValue() {
            return this.val;
        }
    }
}    
```
不能用pq解，不是最优解
follow up:
把每个 meeting room 中的 intervals 打印出来
