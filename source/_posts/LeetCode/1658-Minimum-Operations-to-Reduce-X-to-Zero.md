---
title: 1658 Minimum Operations to Reduce X to Zero
date: 2020-12-26 07:25:32
categories: LeetCode
tags:
---


```java
class Solution {
    public int minOperations(int[] nums, int x) {
        
        Map<Integer, Integer> map = new HashMap<>();
        int res = Integer.MAX_VALUE;
        int sum = 0;
        map.put(0, -1);
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            map.put(sum, i);
            if (sum == x)
            res = Math.min(Integer.MAX_VALUE, i+1);
        }
        
        sum = 0;
        for(int i = nums.length - 1; i >= 0; i--) {
            sum += nums[i];
            if (map.containsKey(x - sum)) {
                if (map.get(x - sum) < i) {
                    res = Math.min(res, nums.length - i  + map.get(x - sum) + 1);
                }
            }
            
            // if (sum == x) {
            //     res = Math.min(res,  nums.length - i);
            // }
        }
        
        return res == Integer.MAX_VALUE ? -1: res;
    }
}
```


```java
class Solution {
    public int minOperations(int[] nums, int x) {
        int sum = 0;
        for (int n : nums) {
            sum += n;
        }
        if (sum == x) {
            return nums.length;
        }
        int res = -1;
        int target = sum - x;
        int left = 0;
        sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            while (sum > target && left <= i) {
                sum -= nums[left++];
            }
            if (sum == target) {
                res = Math.max(res, i - left + 1);
            }
        }
        return res == -1 ? -1 : nums.length - res;
    }
}
```

