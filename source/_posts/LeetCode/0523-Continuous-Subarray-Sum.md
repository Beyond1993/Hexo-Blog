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

```python
class Solution:
    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        ## 如果只是求连续数组和为 K
        ## 对于到i的sum, 肯定有  0 ~ j (j < i) 的sub_sum, sub_sum + k = sum 
        ## sub_sum = sum - k
        ## 用一个 sum_set, if (sum - k) in sum_set: return true
        ## 现在是 sum - sub_sum = n * k
        ## 得 (sum - sub_sum) % k = 0
        ## 根据同余定理 sum % k - sub_sum % k = 0
        ## sum % k = sub_sum % k
        ## 所以只要 sum % k 出现在set 里就说明, sum % k = sub_sum % k, return true
        ## 加上 最少两个数字的要求，所以可以用map 记录index, 要求sum %k, 和sub_sum % k 之差 大于1
        ## 最后sum_map 要初始化成 {0, -1}, 这是针对 从0开始的 subarray
        sum_map = {0: -1}
        sum_ = 0
        for i in range(len(nums)):
            sum_ += nums[i]
            
            sum_ = sum_ % k

            if sum_ in sum_map:
                if i - sum_map[sum_] > 1: 
                    return True
            else:
                sum_map[sum_] = i
        return False
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
