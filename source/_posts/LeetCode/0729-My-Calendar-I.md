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

```python
class MyCalendar:

    def __init__(self):
        self.books = sortedcontainers.SortedDict()

    def floor_key(self, key):
        i = self.books.bisect_right(key)
        if i == 0:
            return None
        return self.books.keys()[i-1]
    
    def ceil_key(self, key):
        i = self.books.bisect_left(key)
        if i == len(self.books.keys()):
            return None
        return self.books.keys()[i]
    

    def book(self, startTime: int, endTime: int) -> bool:
        ## find previous book
        ## prev_start <= startTime
        prev_start = self.floor_key(startTime)
        if prev_start is not None:
            prev_end = self.books[prev_start]
            if prev_end > startTime: return False
        
        ## find next interval
        ## next_start >= startTime
        next_start = self.ceil_key(startTime)
        if next_start is not None:
            next_end = self.books[next_start]
            if next_start < endTime: return False
        self.books[startTime] = endTime
        return True


# Your MyCalendar object will be instantiated and called as such:
# obj = MyCalendar()
# param_1 = obj.book(startTime,endTime)
```




```python
class MyCalendar:

    def __init__(self):
        self.books = []
        

    def book(self, startTime: int, endTime: int) -> bool:
        for book in self.books:
            ## 大头小于小尾 就一定有交集，这是判断两个interval 交集的公式
            if max(startTime, book[0]) < min(book[1], endTime):
                return False
        self.books.append([startTime, endTime])
        return True

# Your MyCalendar object will be instantiated and called as such:
# obj = MyCalendar()
# param_1 = obj.book(startTime,endTime)
```

再跟新两个只用 bisect_right的写法
```python
import bisect

class MyCalendar:
    def __init__(self):
        self.bookings = []  # [(start, end)]

    def book(self, start, end):
        i = bisect.bisect_right(self.bookings, (start, end))

        # 检查前一个区间冲突
        if i > 0 and self.bookings[i-1][1] > start:
            return False
        
        # 检查后一个区间冲突
        if i < len(self.bookings) and self.bookings[i][0] < end:
            return False
        
        # 无冲突 -> 插入
        self.bookings.insert(i, (start, end))
        return True
```
这里的insert O（N）， 可以优化

```python
from sortedcontainers import SortedList

class MyCalendar:
    def __init__(self):
        self.bookings = SortedList()

    def book(self, start, end):
        i = self.bookings.bisect_right((start, end))

        # 检查前一个区间
        if i > 0 and self.bookings[i-1][1] > start:
            return False
        # 检查后一个区间
        if i < len(self.bookings) and self.bookings[i][0] < end:
            return False

        # 插入 O(log N)
        self.bookings.add((start, end))
        return True
```

全都用 bisect_right 的写法
```python
import sortedcontainers

class MyCalendar:
    def __init__(self):
        self.books = sortedcontainers.SortedDict()  # {start: end}

    def floor_key(self, key):
        """最后一个 <= key 的 start"""
        i = self.books.bisect_right(key)
        if i == 0:
            return None
        return self.books.keys()[i-1]

    def ceil_key(self, key):
        """第一个 >= key 的 start（用 bisect_right 也可以）"""
        i = self.books.bisect_right(key)
        if i == len(self.books):
            return None
        # 如果 key 本身存在，ceil 就是它本身
        if i > 0 and self.books.keys()[i-1] == key:
            return self.books.keys()[i-1]
        return self.books.keys()[i]

    def book(self, startTime: int, endTime: int) -> bool:
        # 1️⃣ 找前一个会议（floor）
        prev_start = self.floor_key(startTime)
        if prev_start is not None:
            prev_end = self.books[prev_start]
            if prev_end > startTime:
                return False

        # 2️⃣ 找后一个会议（ceil）
        next_start = self.ceil_key(startTime)
        if next_start is not None:
            next_end = self.books[next_start]
            if next_start < endTime:
                return False

        # 3️⃣ 插入 O(log N)
        self.books[startTime] = endTime
        return True
```

http://47.113.101.198/2025/04/15/Python/Python-Bisect/
