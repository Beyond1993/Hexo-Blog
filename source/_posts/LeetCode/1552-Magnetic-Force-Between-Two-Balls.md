---
title: 1552. Magnetic Force Between Two Balls
date: 2020-08-23 05:07:23
categories: LeetCode
tags:
---

给一组数，选其中 m  个，得到一个最大差值

```java
class Solution {
    public int maxDistance(int[] pos, int m) {
        Arrays.sort(pos);
        int left = 0;
        int right = pos[pos.length - 1] - pos[0];
        while(right > left) {
            int mid = right - (right - left ) / 2;
            int count  = countBalls(pos, pos.length, mid);
            if (count >= m) {
               left = mid;
            } else {
               right = mid - 1;
            }
        }
        return left;
    }
    
   int countBalls(int pos[],  int n, int k) { 
        int count = 1; 
        int last = pos[0];
        for (int i = 1; i < n; i++) {
            if (pos[i] - last >= k) {
                count++;
                last = pos[i];
            }
        }
        return count; 
    }    
}
```
