---
title: 0356 Line Reflection
date: 2021-03-28 13:40:03
categories: LeetCode
tags:
---

Given n points on a 2D plane, find if there is such a line parallel to y-axis that reflect the given points symmetrically, in other words, answer whether or not if there exists a line that after reflecting all points over the given line the set of the original points is the same that the reflected ones.

Note that there can be repeated points.

Follow up:
Could you do better than O(n2) ?

```java
class Solution {
    public boolean isReflected(int[][] points) {
        int x_min = Integer.MAX_VALUE;
        int x_max = Integer.MIN_VALUE;
        
        Map<Integer, Integer> map = new HashMap<>();
        
        int length = points.length;
        for (int i = 0; i<length; i++) {
            points[i][0] = points[i][0] * 10;
            points[i][1] = points[i][1] * 10;
            
            int x = points[i][0];
            int y = points[i][1];
            
            if (x < x_min) x_min = x;
            if (x > x_max) x_max = x;
            
            int key = generate_key(x, y);
            map.put(key,key); // key hashed here 
        }
        int x_mid = (x_min + x_max) / 2;
        
        for (int i = 0; i<length; i++) {
            int x_one_side = points[i][0];
            int y = points[i][1];
            int x_other_side = x_mid + (x_mid - x_one_side);
            
            int key = generate_key(x_other_side, y);
            Integer point = map.get(key);
            if (point == null) {
                return false;
            }
        }
        
        return true;
        
    }
    
    private int generate_key(int x, int y){
        return x * 31 + y * 31 * 31;
    }
}
```
