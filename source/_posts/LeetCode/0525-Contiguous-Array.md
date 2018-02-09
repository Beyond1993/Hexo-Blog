---
title: 0525 Contiguous Array
date: 2018-02-08 20:35:09
categories: LeetCode
tags: Facebook
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


这题的方法很巧妙，先用一个count计数，0 就 减一, 1 就 加 1

当两次 count 相同的时候，就说明之间的0,1是一样的。

第一种直接用一个数组存所有count的种类，也就是从 -count ~ count

但其实不是所有的count 都是有效的.

所以用HashMap 比较靠谱.

```java
public class Solution {
  public int findMaxLength(int [] nums) {
    Map<Integer, Integer> map = new HashMap<Integer, Integer>();
    map.put(0,-1);
    int maxLen = 0, count = 0;
    for (int i = 0; i < nums.length; i++) {
      count += nums[i] == 1 ? -1;
      if (map.contains(count)) {
        maxLen = Math.max(maxLen, i - map.get(count);
      } else {
        map.put(count, i);
      }
    }
    return maxLen;
  }
}

```


