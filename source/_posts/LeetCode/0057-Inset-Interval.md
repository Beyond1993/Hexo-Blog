---
title: 0057 Insert Interval
date: 2019-07-25 02:41:20
categories: LeetCode
tags:
---
这题的关键在于，中间这段的判断， 不需要写的很复杂：
while i < n and intervals[i][0] <= newInterval[1]
```python
class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        if not intervals:
            return [newInterval]
        res = []
        n = len(intervals)
        i = 0
        while i < n and intervals[i][1] < newInterval[0]:
            res.append(intervals[i])
            i += 1
        start, end = newInterval[0], newInterval[1]
        while i < n and intervals[i][0] <= newInterval[1]:
            start = min(intervals[i][0], newInterval[0], start)
            end = max(intervals[i][1], newInterval[1], end)
           # print(start, end)
            i += 1
        res.append([start, end])

        while i < n and intervals[i][0] > newInterval[1]:
            res.append(intervals[i])
            i += 1

        return res
```


```java
public List<Interval> insert(List<Interval> intervals, Interval newInterval) {
    List<Interval> result = new LinkedList<>();
    int i = 0;
    // add all the intervals ending before newInterval starts
    while (i < intervals.size() && intervals.get(i).end < newInterval.start)
        result.add(intervals.get(i++));
    // merge all overlapping intervals to one considering newInterval
    while (i < intervals.size() && intervals.get(i).start <= newInterval.end) {
        newInterval = new Interval( // we could mutate newInterval here also
                Math.min(newInterval.start, intervals.get(i).start),
                Math.max(newInterval.end, intervals.get(i).end));
        i++;
    }
    result.add(newInterval); // add the union of intervals we got
    // add all the rest
    while (i < intervals.size()) result.add(intervals.get(i++)); 
    return result;
}
```

这个解，就是分三段，第一段把 不在 newInterval 内的解加进去，
第二段就是合并，第三段把多余的解加进去。

```java
public List<Interval> insert(List<Interval> intervals, Interval newInterval) {
        TreeMap<Integer, Interval> treeMap = new TreeMap<>();
        for(Interval interval : intervals) {
            treeMap.put(interval.start, interval);
        }
        Interval cur = newInterval;
        
        while(treeMap.floorEntry(cur.end) != null && treeMap.floorEntry(cur.end).getValue().end >= cur.start) {
         
            if(treeMap.floorEntry(cur.start) != null && treeMap.floorEntry(cur.start).getValue().end >= cur.start) {
                Interval out = treeMap.floorEntry(cur.start).getValue();
                treeMap.remove(treeMap.floorKey(cur.start));
                cur.start = out.start;
                cur.end = Math.max(cur.end, out.end);
            }else{
                Interval out = treeMap.floorEntry(cur.end).getValue();
                treeMap.remove(treeMap.floorKey(cur.end));
                cur.end = Math.max(cur.end, out.end);
                cur.start = Math.min(cur.start, out.start);
            }
            
        }
        treeMap.put(cur.start, cur);
        return new ArrayList<>(treeMap.values());
    }
```
