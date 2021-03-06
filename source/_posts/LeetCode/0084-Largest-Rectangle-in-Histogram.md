---
title: 0084 Largest Rectangle in Histogram
date: 2018-07-23 07:07:21
categories: LeetCode
tags:
---

Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.


Above is a histogram where width of each bar is 1, given height = [2,1,5,6,2,3].

```java
public class Solution {
    public int largestRectangleArea(int[] heights) {
        if (heights.length == 0) {
            return 0;
        }
        
        Stack<Integer> s = new Stack<Integer>();
        int max = 0;
        for (int i = 0; i <= heights.length; i++) {
            // -1 可以把最高高度扫一遍
            int cur = i == heights.length ? -1: heights[i];
            while (!s.isEmpty() && cur < heights[s.peek()]) {
                int h = heights[s.pop()];
                // 这个宽度， 很精妙
                // 如果 stack 是空， 说明没有 比当前高度更高的了
                // 就把当前最低高度 乘以 i 就可以了
                int w = s.isEmpty() ? i : i - s.peek() -1;
                max = Math.max(max, h * w);
            }
            s.push(i);
        }
        return max;
    }
}
```
