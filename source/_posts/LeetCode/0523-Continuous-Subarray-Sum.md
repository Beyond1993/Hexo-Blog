---
title: 0523 Continuous Subarray Sum
date: 2018-02-17 19:28:20
categories: LeetCode
tags:
---

Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.

Example 1:
Input: [0,1]
Output: 2
Explanation: [0, 1] is the longest contiguous subarray with equal number of 0 and 1.
Example 2:
Input: [0,1,0]
Output: 2
Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
Note: The length of the given binary array will not exceed 50,000.


```java
class Solution {
    public boolean checkSubarraySum(int[] nums, int k) {
        int sum = 0;
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        map.put(0,-1);
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            if (k != 0) {
              sum = sum % k;
            }
            
            if (map.containsKey(sum)) {
                if (i - map.get(sum) > 1) {
                    return true;
                }
            } else {
                map.put(sum, i); 
            }
            
        }
        return false;
    }
}
```

有一个 similar 的问题:

Q10 given an unsorted array, count how many contiguous subarray which sum equals to target

```java
public int countOfSubArraySum(int[] array, int target) {
  if (array == null || array.length < 2) return 0;
  int sum = 0, result = 0;
  Map<Integer, Integer> preSum = new HashMap<>();
  preSum.put(0,1);

  for (int i = 0; i < array.length; i++) {
    sum += array[i];
    result += preSum.getOrDefault(sum - target, 0);
    preSum.put(sum, preSum.getOrDefault(sum, 0) + 1);
  }
  
  return result;
}
```


这题的核心就是 sum2 - sum1 = target



