---
title: 0011 Container With Most Water
date: 2017-12-26 17:38:50
categories: LeetCode
tags:
---

题目描述

Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

Note: You may not slant the container and n is at least 2.

这题用对撞型两指针很简单。但是要想到怎么会用对撞型两指针。
最直观的想法就是 把所有的点都组合一下，算面积。但这种O(n^2) 显然不是题目要求的。


设置两个指针i, j, 一头一尾, 相向而行. 假设i指向的挡板较低, j指向的挡板较高(height[i] < height[j]).
    下一步移动哪个指针?
    -- 若移动j, 无论height[j-1]是何种高度, 形成的面积都小于之前的面积.
    -- 若移动i, 若height[i+1] <= height[i], 面积一定缩小; 但若height[i+1] > height[i], 面积则有可能增大.
综上, 应该移动指向较低挡板的那个指针.

```java
public class Solution {
    public int maxArea(int[] height) {
        int right = height.length - 1;
        int left = 0;
        int capability = 0;
        while(left<right){
            int area = Math.min(height[right], height[left]) * (right - left);
            
            if(area > capability) capability = area;
            
            if(height[left] < height[right]) left++;
            
            else right--;
        }
        return capability;
    }
}
```
