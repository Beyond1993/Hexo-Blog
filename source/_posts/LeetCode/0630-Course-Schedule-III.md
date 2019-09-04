---
title: 0630 Course Schedule III
date: 2018-01-08 05:01:29
categories: LeetCode
tags:
---

There are n different online courses numbered from 1 to n. Each course has some duration(course length) t and closed on dth day. A course should be taken continuously for t days and must be finished before or on the dth day. You will start at the 1st day.

Given n online courses represented by pairs (t,d), your task is to find the maximal number of courses that can be taken.

**Example:**
Input: [[100, 200], [200, 1300], [1000, 1250], [2000, 3200]]
Output: 3
Explanation: 
There're totally 4 courses, but you can take 3 courses at most:
First, take the 1st course, it costs 100 days so you will finish it on the 100th day, and ready to take the next course on the 101st day.
Second, take the 3rd course, it costs 1000 days so you will finish it on the 1100th day, and ready to take the next course on the 1101st day. 
Third, take the 2nd course, it costs 200 days so you will finish it on the 1300th day. 
The 4th course cannot be taken now, since you will finish it on the 3300th day, which exceeds the closed date.

Note:
The integer 1 <= d, t, n <= 10,000.
You can't take two courses simultaneously.

(t,d) 表示这门课必须要连续上t天, 但是这门课的截止日期是第d天.

一天只能上一门课(虽然对这个表示不能苟同), 求我们怎么选可以选最多的课。

```java
class Solution {
    public int scheduleCourse(int[][] courses) {
        Arrays.sort(courses, (a,b) -> a[1] - b[1]);
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        int total = 0;
        for (int[] course : courses) {
            int days = course[0];
            int deadline = course[1];
            pq.offer(days);            
            total += days;
            while(total > deadline) {
                total -= pq.poll();
            }
        }
        return pq.size();
    }
}
``` 

这题就是贪心算法, 先按照截止日期排序，时间不够里 再不断从最大堆里拿出 duration，

其实这里我想说的是，关于贪心算法，这真的是在计算机算法家族中，最接近人类思维的了。 局部最优就是全局最优，总让人感觉不放心。
