---
title: 0128 Longest Consecutive Sequence
date: 2019-09-20 03:00:27
categories: LeetCode
tags:
---

Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

Your algorithm should run in O(n) complexity.

Example:

Input: [100, 4, 200, 1, 3, 2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

// 100, 99, 101, 1
// 4 3, 5, len 1
    
    
// 1, len = 1
// 3, 4  ==> len 2
    
// 2, left 1, right 2 ==> 4, 

// 3 len 2
// 4 len 4
// 1 len 4
    
// 0  1,2,3,4   5,6,7..    
只需要跟新 两端的节点，因为中间的访问不到。

```java
class Solution {
    public int longestConsecutive(int[] nums) {
        int res = 0;
        Map<Integer, Integer> map = new HashMap<>();
        for (int n : nums) {
            if (!map.containsKey(n)) {
                int left = map.getOrDefault(n - 1, 0);
                int right = map.getOrDefault(n + 1, 0);
                int sum = left + 1 + right;
                res = Math.max(res, sum);
                map.put(n, sum);
                map.put(n - left, sum);
                map.put(n + right, sum);
            }
        }
        return res;
    }
}
```

