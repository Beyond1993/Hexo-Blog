---
title: 0673 Number of Longest Increasing Subsequence
date: 2019-05-16 21:43:30
categories:
tags:
---


solution 1:

```java

class Solution {
    public int findNumberOfLIS(int[] nums) {
        if (nums.length == 0) return 0;
        
        // len[i] means the length of longest increasing sequence of nums[i]
        // count[i] means the how many different path of current sequence of nums[i]
        int[] len = new int[nums.length];
        int[] count = new int[nums.length];
        int res = 0;
        int maxLen = 1;
        
        for (int i = 0; i < nums.length; i++) {
            len[i] = 1;
            count[i] = 1;
        }
        
        //        1, 3, 5, 4, 7
        // len    1  2  3  3  4
        // count  1  1  1  1  2
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                                      
                    if (len[i] == len[j] + 1) {
                        // means one more path
                        count[i] = count[j] + count[i];
                    }
                    
                    if (len[i] < len[j] + 1) {
                        len[i] = len[j] + 1;
                        count[i] = count[j];
                    }
                }          
            }
            
            //System.out.println(len[i]+ " " + count[i]);
            
            if (maxLen == len[i]) {
                res += count[i];
            }
            
            if (maxLen < len[i]) {
                 maxLen = len[i];
                 res = count[i];
            }
        }
        
        //      2,2,2,2,2
        // len  1,1
        // index should start from 0
        return res;
    }
}

```

solution 2
```java

class Solution {
    public int findNumberOfLIS(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        
        // populate longest dp
        int[] dp = new int[nums.length + 1];
        Arrays.fill(dp, 1);
        
        int[] counts = new int[nums.length + 1];
        counts[0] = 1;
        
        int longest = 1;
        for (int i = 1; i < nums.length; ++ i) {
            for (int j = 0; j < i; ++ j) {
                if (nums[j] < nums[i]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                    longest = Math.max(longest, dp[i]);
                }
            }
            // init counts
            if (dp[i] == 1) {
                counts[i] = 1;
            }
        }
        
        // populate longest path count
        dp[nums.length] = longest + 1;
        
        for (int i = 1; i < dp.length; ++ i) {
            for (int j = 0; j < i; ++ j) {
                if (dp[j] + 1 == dp[i] 
                    && (i == nums.length || nums[j] < nums[i])) {
                    counts[i] += counts[j];
                }
            }
        }
        return counts[nums.length];
    }
}
```
