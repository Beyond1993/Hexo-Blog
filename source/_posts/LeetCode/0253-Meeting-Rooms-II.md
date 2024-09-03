---
title: 0253-Meeting-Rooms-II
date: 2018-09-16 22:05:30
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
            } else {  
                rooms++;  
            }  

            minHeap.add(intervals[i].end);  
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

```python
def minMeetingRooms(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x : x[0])
        min_heap = []
        room = 0
        for interval in intervals:
            if not min_heap:
                heapq.heappush(min_heap, interval[1])
                room += 1
                continue
            if min_heap[0] <= interval[0]:
                heapq.heappop(min_heap)
            else:
                room += 1
                
            heapq.heappush(min_heap, interval[1])

        return room
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

pq 解 时间复杂度 NlogN, 空间复杂度 N

这题可以用经典的扫描线算法。

时间复杂度 NlogN, 空间复杂度 N


```text
    y
|     ↑   [5,10]
|     |    +----+ 
|     | 
|-->  |              [15,20]
|     |              +----+
|     | 
|     |           [0,30]
|     +-----------------------------+
|     |
|     +----+----+----+----+----+----+-->x
      0    5    10   15   20   25   30
```
左边的扫描线 从左往右扫描，记录交点，更新最多的交点数。

-对所有点进行标记，区分起始点和终止点 
-对所有点（包括起始点 和  中止点) 进行排序 
-依次遍历每个点，遇到起始点+1，遇到终止点-1，并更新记录最大值

```java
public class Solution {  
    public int minMeetingRooms(Interval[] intervals) {  
        Map<Integer, Integer> m = new TreeMap(); // we must use a sorted map
        for (Interval i : intervals) {
            m.put(i.start, m.getOrDefault(i.start, 0) + 1);
            m.put(i.end, m.getOrDefault(i.end, 0) - 1);
        }
        int curRooms = 0, maxRooms = 0;
        for (Integer time : m.keySet()) {
            maxRooms = Math.max(maxRooms, curRooms += m.get(time));
        }
        return maxRooms;
    }  

}  
```

|Point |   Value |curRoom|
|:-----|:--------|:------|
|  0   |  1      | 1     |
|  5   |  1      | 2     |
|  10  | -1      | 1     |
|  15  |  1      | 2     |
|  20  | -1      | 1     |
|  30  | -1      | 0     |

follow up:
把每个 meeting room 中的 intervals 打印出来


```java
class Solution {
    public int minMeetingRooms(int[][] intervals) {
        Integer[] nums = new Integer[intervals.length * 2];
        int index = 0;
        for (int i = 0; i < intervals.length; i++) {
            nums[index++] = intervals[i][0];
            nums[index++] = -intervals[i][1];
        }
        
        Arrays.sort(nums, new Comparator<Integer>() { 
            public int compare(Integer a, Integer b) {
                if ( Math.abs(a) == Math.abs(b)) {
                    return a - b;
                }
                return Math.abs(a) - Math.abs(b);
            }
        });
        
        int count = 0;
        int max = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] >= 0) {
                count++;
                max = Math.max(max, count);
            } else {
                count--;
            }
        }
        return max;
    }
}
```

