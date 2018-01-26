---
title: 0149 Max Points on a Line
date: 2018-01-26 02:57:51
categories: LeetCode
tags:
---

Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.

```java
public int maxPoints(Point[] points) {
        if (points == null || points.length == 0) return 0;
        int maxNum = 1;
        Map<Double, Integer> map = new HashMap<Double, Integer>();
        for (int i = 0; i < points.length; i++) {
            int samePoint = 1;
            map.clear();
            for (int j = i + 1; j < points.length; j++) {
                if (points[i].x == points[j].x && points[i].y == points[j].y) {
                    samePoint ++;
                } else if (points[i].x == points[j].x) {
                    map.put(Double.MAX_VALUE, map.getOrDefault(Double.MAX_VALUE,0) + 1);
                } else {
                    double rate = (double)(points[i].y - points[j].y) / (points[i].x - points[j].x);
                    if (Math.abs(rate) == 0)  rate = 0;
                    System.out.println(rate +" ..");
                    map.put(rate, map.getOrDefault(rate, 0) + 1);
                }
            }
            int local = 0;
            for (Double e : map.keySet()) {
                System.out.print(map.get(e) + " ? " + e);
                local = Math.max(local, map.get(e));
            }
            System.out.println("\n" + local + " " + samePoint);
            maxNum = Math.max(maxNum, local + samePoint);
        }
        return maxNum;
    }
```

每次从一个点出发，找后面所有点的斜率，和相同的点，平行于Y轴的线，斜率为正无穷.
平行于 X轴的线，斜率为0
先找出出现点次数最多的斜率，再加上 samePoints.

之前算过的起始点，不用重复计算。请看两个for 循环
