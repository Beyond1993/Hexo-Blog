---
title: 0056-Merge-Interval
date: 2018-02-01 17:06:07
categories: LeetCode
tags:
---

题目描述：
Given a collection of intervals, merge all overlapping intervals.

For example,
Given [1,3],[2,6],[8,10],[15,18],
return [1,6],[8,10],[15,18].

思路: 保持两个记录位置。start, end. 先按照start排序，若果 Ki+1.start <= Ki.end, 说明有重叠，end = Ki+1.end  或者 Ki.end

```java
public List<Interval> merge(List<Interval> intervals) {
    if (intervals.size() <= 1)
        return intervals;
    
    // Sort by ascending starting point using an anonymous Comparator
    intervals.sort((i1, i2) -> Integer.compare(i1.start, i2.start));
    
    List<Interval> result = new LinkedList<Interval>();
    int start = intervals.get(0).start;
    int end = intervals.get(0).end;
    
    for (Interval interval : intervals) {
        if (interval.start <= end) // Overlapping intervals, move the end if needed
            end = Math.max(end, interval.end);
        else {                     // Disjoint intervals, add the previous one and reset bounds
            result.add(new Interval(start, end));
            start = interval.start;
            end = interval.end;
        }
    }
    
    // Add the last interval
    result.add(new Interval(start, end));
    return result;
}
```

follow up [The-Sky-Line-Problem](http://52.14.116.56/2017/10/09/LeetCode/0218-The-Skyline-Problem/)


```java
class Solution {
    public int[][] merge(int[][] intervals) {
        if (intervals == null || intervals.length == 0) {
            return intervals;
        }
        List<int[]> res = new ArrayList<int[]>();
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        res.add(intervals[0]);
        for (int i = 1; i < intervals.length; i++) {
            int[] cur = intervals[i];
            
            if (cur[0] <= res.get(res.size() - 1)[1]) {
                res.get(res.size() - 1)[1] = Math.max(cur[1], res.get(res.size() - 1 )[1]);
            } else {
                res.add(cur);
            }   
        }
        int[][] result = new int[res.size()][2];
        for (int i = 0; i < res.size(); i++) {
            result[i] = res.get(i);
        }
        return result;
    }
}
```
