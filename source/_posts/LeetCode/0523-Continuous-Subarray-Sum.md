---
title: 0523 Continuous Subarray Sum
date: 2018-02-17 19:28:20
categories: LeetCode
tags:
---







又一个 similar 的问题:

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



