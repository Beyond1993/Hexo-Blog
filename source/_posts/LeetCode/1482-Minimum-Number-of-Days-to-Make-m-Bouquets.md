---
title: 1482. Minimum Number of Days to Make m Bouquets
date: 2020-09-20 06:10:56
categories: LeetCode
tags:
---

```java
class Solution {
    public int minDays(int[] bloomDay, int m, int k) {
        int left = 0;
        int right = Integer.MAX_VALUE;
        
        while(left < right) {
            int mid = left + (right - left) / 2;
            
            if (helper(mid, bloomDay, k) >= m) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        
        return left == Integer.MAX_VALUE ? -1 : left;
    }
    
    int helper(int day, int[] bloomDay, int k) {
        int start = 0;
        int count = 0;
        while(start <= bloomDay.length - k) {
            if (bloomDay[start] > day) {
                start++;
            } else {
                boolean flag = false;
                for (int i = 0; i < k; i++) { 
                    if (bloomDay[i + start] > day) {
                        flag = true;
                        break;
                    } 
                }
                
                if (flag) {
                    start++;
                } else {
                    start += k;
                    count++;
                }
            }
        }
        return count;
    }
}
```

```java
class Solution {
    public int minDays(int[] bloomDay, int m, int k) {
        int left = 0;
        int right = Integer.MAX_VALUE;
        
        while(left < right) {
            int mid = left + (right - left) / 2;
            
            if (helper(mid, bloomDay, k) >= m) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        
        return left == Integer.MAX_VALUE ? -1 : left;
    }
    
    int helper(int day, int[] bloomDay, int k) {
        int flower = 0, bouquet = 0;
        for(int i = 0; i < bloomDay.length; i++) {
                if(bloomDay[i] > day) {
                    flower = 0;
                } else if(++flower == k) {
                    flower = 0;
                    bouquet++;
                }
            }
        
        return bouquet;
    }
}
```

```java
class Solution {
    public int minDays(int[] bloomDay, int m, int k) {
        int left = 1, right = Integer.MAX_VALUE;
        while(left < right) {
            int mid = left + (right - left) / 2;
            int flower = 0, bouquet = 0;
            for(int i = 0; i < bloomDay.length; i++) {
                if(bloomDay[i] > mid) {
                    flower = 0;
                } else if(++flower == k) {
                    flower = 0;
                    bouquet++;
                }
            }
            if(bouquet < m) left = mid + 1;
            else right = mid;
        }
        return left == Integer.MAX_VALUE ? -1 : left;
    }
}
```
