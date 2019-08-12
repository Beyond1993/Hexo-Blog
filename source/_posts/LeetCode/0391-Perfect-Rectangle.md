---
title: 0391-Perfect-Rectangle
date: 2017-10-16 06:29:39
categories: LeetCode
tags:
---

完美三角形．给出若干个矩形的左下和右上角坐标．判断这些矩形能不能刚好组成一个大的矩形．不能有重叠，不能有空隙．



这题的思路是：

１．最外面的四个点只出现一次，　其余点均出现两个．

２．最外面四个点构成的矩形面积刚好是所有小矩形的面积之和．

```java
public boolean isRectangleCover(int[][] rectangles) {

        if (rectangles.length == 0 || rectangles[0].length == 0) return false;

        int x1 = Integer.MAX_VALUE;
        int x2 = Integer.MIN_VALUE;
        int y1 = Integer.MAX_VALUE;
        int y2 = Integer.MIN_VALUE;
        
        HashSet<String> set = new HashSet<String>();
        int area = 0;
        
        for (int[] rect : rectangles) {
            x1 = Math.min(rect[0], x1);
            y1 = Math.min(rect[1], y1);
            x2 = Math.max(rect[2], x2);
            y2 = Math.max(rect[3], y2);
            
            area += (rect[2] - rect[0]) * (rect[3] - rect[1]);
            
            String s1 = rect[0] + " " + rect[1];
            String s2 = rect[0] + " " + rect[3];
            String s3 = rect[2] + " " + rect[3];
            String s4 = rect[2] + " " + rect[1];
            
            if (!set.add(s1)) set.remove(s1);
            if (!set.add(s2)) set.remove(s2);
            if (!set.add(s3)) set.remove(s3);
            if (!set.add(s4)) set.remove(s4);
        }
        
        if (!set.contains(x1 + " " + y1) || !set.contains(x1 + " " + y2) || !set.contains(x2 + " " + y1) || !set.contains(x2 + " " + y2) || set.size() != 4) return false;
        
        return area == (x2-x1) * (y2-y1);
    }
```

在set insert 后，　返回一个pair< set<>::iterator, bool> 插入成功则为true, 插入失败则为false.

扫描线算法: 


```java
public class Event implements Comparable<Event> {
    int time;
    int[] rect;

    public Event(int time, int[] rect) {
        this.time = time;
        this.rect = rect;
    }
    
    public int compareTo(Event that) {
        if (this.time != that.time) return this.time - that.time;
        else return this.rect[0] - that.rect[0];
    }
}

public boolean isRectangleCover(int[][] rectangles) {
    PriorityQueue<Event> pq = new PriorityQueue<Event> ();
        // border of y-intervals
    int[] border= {Integer.MAX_VALUE, Integer.MIN_VALUE};
    for (int[] rect : rectangles) {
        Event e1 = new Event(rect[0], rect);
        Event e2 = new Event(rect[2], rect);
        pq.add(e1);
        pq.add(e2);
        if (rect[1] < border[0]) border[0] = rect[1];
        if (rect[3] > border[1]) border[1] = rect[3];
    }
    TreeSet<int[]> set = new TreeSet<int[]> (new Comparator<int[]> () {
        @Override
                // if two y-intervals intersects, return 0
        public int compare (int[] rect1, int[] rect2) {
            if (rect1[3] <= rect2[1]) return -1;
            else if (rect2[3] <= rect1[1]) return 1;
            else return 0;
        }
    });
    int yRange = 0;
    while (!pq.isEmpty()) {
        int time = pq.peek().time;
        while (!pq.isEmpty() && pq.peek().time == time) {
            Event e = pq.poll();
            int[] rect = e.rect;
            if (time == rect[2]) {
                set.remove(rect);
                yRange -= rect[3] - rect[1];
            } else {
                if (!set.add(rect)) return false;
                yRange += rect[3] - rect[1];
            }
        }
                // check intervals' range
        if (!pq.isEmpty() && yRange != border[1] - border[0]) {
                        return false;
            //if (set.isEmpty()) return false;
            //if (yRange != border[1] - border[0]) return false;
        }
    }
    return true;
}
```

treeSet  仅仅是用来去重。

x 轴 方向, 如果有重叠，会 yRange 会加两次






