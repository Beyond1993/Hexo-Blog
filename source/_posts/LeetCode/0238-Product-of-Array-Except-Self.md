---
title: 0238 Product of Array Except Self
date: 2019-06-24 00:15:33
categorieso: LeetCode
tags:
---


```java
// 算左边的乘积，再算右边的乘积
public class Solution {
    public int[] productExceptSelf(int[] nums) {
        int[] res= new int[nums.length];
        res[0] = 1;
        for (int i = 1; i <nums.length; i++) {
            res[i] = res[i-1] * nums[i-1];
        }
        
        int right = 1;
        for(int i = nums.length -1; i >=0; i--) {
            res[i] = right * res[i];
            right = right * nums[i];
        }
        
        return res;
    }
}
```
