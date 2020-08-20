---
title: Interval-Questions
date: 2017-10-09 19:23:39
categories: LeetCode-Index
tags:
---

一般扫描线问题都有两种解法，Sort 或者 priorityQueue

但是 priorityQueue 本身就是 sort 的一种形式


区间问题的现实意义就是,工作中很多数据都是一段一段的。

区间合并问题,包括摩天大楼问题

一般都是interval, 排序，然后用

Priority Queue

TreeMap, TreeSet

Interval 重叠公式

排序 双指针


meeting-room 问题
https://leetcode.com/problems/meeting-rooms/description/
https://leetcode.com/problems/meeting-rooms-ii/description/

### meeting rooms II

### 题目:

给出一组会议时间间隔，这些间隔由开始时间和结束时间构成,

[[s1,e1],[s2,e2],...] (si < ei), 找出最少需要几间会议室

例子1:
```txt
Input: [[0, 30],[5, 10],[15, 20]]
Output: 2
```

例子2:
```txt
Input: [[7,10],[2,4]]
Output: 1
```

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

### 找出同时开会的会议室有几个

### 找出包含最多会议的开始时间和结束时间

```java
import java.util.*;

public class Main {
    public static void main(String[] args){
        int[][] intervals = {{0,1,2}, {1,1,2}, {2,1,2}, {3,3,6}, {4,4,5}, {5,3,8}, {6,4,7}};
        int[] res = getMaxNmuberInterval(intervals);
        System.out.println(res[0] + "\t" + res[1]);
    }
    public static int[] getMaxNmuberInterval(int[][] intervals) {
        List<Integer> points = new ArrayList<>();
        for (int[] interval : intervals) {
            // ignore the interval[0]
            points.add(interval[1]);
            points.add(- (interval[1] + interval[2]));
        }

        points.sort(new Comparator<Integer>() {
            @Override
            public int compare(Integer a, Integer b) {
                if (Math.abs(a) != Math.abs(b)) {
                    return Math.abs(a) - Math.abs(b);
                } else {
                    return a - b;
                }
            }
        });    
        
        int size = 0;
        int left = 0, right = 0;
        int maxLeft = 0, maxRight = 0;
        int maxSize = 0;
        for (int e : points) {
            if (e >= 0) {
                ++ size;
                left = e;
            } else {
                right = e;
                if (size > maxSize) {
                    maxSize = size;
                    maxLeft = left;
                    maxRight = - right;
                }
                -- size;
            }
        }
        return new int[] {maxLeft, maxRight};
    }
    
    public static int[] f_2(int[][] intervals) {
        TreeMap<Integer, Integer> map = new TreeMap<>();
        for (int[] interval : intervals) {
            map.put(interval[0], map.getOrDefault(interval[0], 0) + 1);
            map.put(interval[1], map.getOrDefault(interval[1], 0) - 1);
        }
        int max = 0;
        int total = 0;
        int left = 0, right = 0;
        int maxLeft = 0, maxRight = 0;
        for (Map.Entry<Integer, Integer> e : map.entrySet()) {
            int k = e.getKey();
            int v = e.getValue();
            
            if (v > 0) {
                left = k;
            } else {
                right = k;
                if (total > max) {
                    maxLeft = left; maxRight = right;
                    max = Math.max(total, max);
                }
            }
            total += v;
            
        }
        return new int[] {maxLeft, maxRight};
    }
}
```

### facebook 面试

给一个 list of interval, 找出最多non overlap count。

example1:

input: (1,4), (2,3) (3,4), (5,6), (7,8)

output: 4

explaination: (2,3), (3,4), (5,6), (7,8)

example2:
input: (1,4), (2,3), (3,9), (5,6), (7,8)
output: 3

explaination: (2,3), (5,6), (7,8)


```java

public int getMaxNonOverlap(int[][] Intervals)
{
    Arrays.sort(intervals, (a, b) -> {
            return a[0] - b[0];
    });
    int[] cur = intervals[0];
    int count = 1;
    for (int i = 1; i < intervals.length; i++) {
         int[] next = intervals[i];
         if (next[0] >= cur[1]) {
            count++;
            cur = next;
         } else if (next[1] < cur[1]) {
            cur = next;
         }   
    }
    return count;   
}

```

### 求

给出没个员工的工作时间间隔, 求最多多少员工一起工作

```java

```

### 求最多时间间隔
#### sort

给出没个员工的工作时间间隔, 求最多多少员工一起工的时间间隔
```java
```

#### pq

759






