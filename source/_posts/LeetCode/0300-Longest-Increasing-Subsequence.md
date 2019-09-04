---
title: 300. Longest Increasing Subsequence
date: 2019-09-02 23:15:36
categories: LeetCode
tags:
---

```java
class Solution {
    public int lengthOfLIS(int[] nums) {
        if (nums.length == 0) return 0;
        
        int[] tails = new int[nums.length];
        tails[0] = nums[0];
        int len = 1;
        
        for (int num : nums) {
            int index = binarySearch(tails, num, len);
            
            if (index >= len) {
                tails[len++] = num;
             } else {
                tails[index] = num;
             }     
        }
        return len;
    }
    
    private int binarySearch(int[] tails, int num, int len) {
    
        int l = 0; //0
        int r = len - 1; //1
        while(l + 1 < r) {
            int mid = l + (r - l) / 2;
            if (tails[mid] == num) {
                return mid;
            } else if (num < tails[mid]) {
                r = mid;
            } else {
                l = mid;
            }
        } 
        
        if (num < tails[0]) {
            return 0;
        } else if (num == tails[l]) {
            return l;
        } else if (tails[l] < num && num <= tails[r]) {
            return r ;
        } else if (num > tails[len-1]) {
            return len; 
        }
        return 0;
    }
}
```

