---
title: 0042 Trapping Rain Water
date: 2018-02-18 03:10:56
categories: LeetCode
tags:
---


Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example, 
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.

![](https://leetcode.com/static/images/problemset/rainwatertrap.png)

https://www.youtube.com/watch?v=8BHqSdwyODs

```java
public class Solution {
    public int trap(int[] A){
        if (A.length == 0) return 0;
        int[] leftMax = new int[A.length];
        int[] rightMax = new int[A.length];
        int left = Integer.MIN_VALUE;
        int right = Integer.MIN_VALUE;
        for (int i = 0; i < A.length; i++) {
            if (A[i] >= left) {
                left = A[i];
            }
            if (i + 1 <= A.length -1) {
              leftMax[i+1] = left;
            }
            int index = A.length - 1 - i;
            if (A[index] >= right) {                
                right = A[index];
            }

            if (index - 1 >= 0) {
              rightMax[index - 1] = right;
            }
        }
        leftMax[0] = rightMax[A.length -1] = 0;
        int sum = 0;
        for (int i = 0; i < A.length; i++) {
            int temp = Math.min(leftMax[i], rightMax[i]) - A[i];
            sum += temp >= 0? temp: 0;
        }
        return sum;
    }
}
```


其实leftMax 和 rightMax 都是单调序列. 所以可以简化
```java
public class Solution {
    public int trap(int[] A){
        int a = 0;
        int b = A.length-1;
        int max = 0;
        int leftmax = 0;
        int rightmax = 0;
        while(a <= b) {
            leftmax = Math.max(leftmax,A[a]);
            rightmax = Math.max(rightmax,A[b]);
            if(leftmax < rightmax){
                max += (leftmax-A[a]);       
                // leftmax is smaller than rightmax, so the (leftmax-A[a]) water can be stored
                a++;
            }
            else{
                max += (rightmax-A[b]);
                b--;
            }
        }
        return max;
    }
}
```



