---
title: 0729-My-Calendar-I
date: 2017-12-07 22:04:40
categories: LeetCode
tags:
---

其实本质就是meeting room

Implement a MyCalendar class to store your events. A new event can be added if adding the event will not cause a double booking.

Your class will have the method, book(int start, int end). Formally, this represents a booking on the half open interval [start, end), the range of real numbers x such that start <= x < end.

A double booking happens when two events have some non-empty intersection (ie., there is some time that is common to both events.)

For each call to the method MyCalendar.book, return true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.

Your class will be called like this: MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)
Example 1:
MyCalendar();
MyCalendar.book(10, 20); // returns true
MyCalendar.book(15, 25); // returns false
MyCalendar.book(20, 30); // returns true
Explanation: 
The first event can be booked.  The second can't because time 15 is already booked by another event.
The third event can be booked, as the first event takes every time less than 20, but not including 20.

Note:

The number of calls to MyCalendar.book per test case will be at most 1000.
In calls to MyCalendar.book(start, end), start and end are integers in the range [0, 10^9].

这题本质上还是interval， 有点像meeting room的 OOD 设计。

**开头的最大值比结尾的最小值要小**

这一句话，就概括了所有的四种重叠的情况。

这一题考的本质是，一个interval 是否重叠的公式。

**if (Math.max(b[0], start) < Math.min(b[1], end)) return false;**

为什么这个公式重要。因为在各大interval 的题型中都能见到他的身影。

```java
class MyCalendar {
    private List<int[]> books;
    public MyCalendar() {
        this.books = new ArrayList<>();
    }
    
    public boolean book(int start, int end) {
        for (int[] b: this.books) {
            if (Math.max(start, b[0]) < Math.min(end,b[1])) {
                return false;
            }
        }
        this.books.add(new int[]{start,end} );
        return true;  
    }
}
```

TreeMap

```java
class MyCalendar {

    TreeMap<Integer, Integer> calendar;

    public MyCalendar() {
        calendar = new TreeMap<>();
    }

    public boolean book(int start, int end) {
        Integer floorKey = calendar.floorKey(start);
        if (floorKey != null && calendar.get(floorKey) > start) return false;
        Integer ceilingKey = calendar.ceilingKey(start);
        if (ceilingKey != null && ceilingKey < end) return false;

        calendar.put(start, end);
        return true;
    }
}
```





