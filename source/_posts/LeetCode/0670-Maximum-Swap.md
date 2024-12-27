---
title: 0670 Maximum Swap
date: 2018-02-14 05:11:44
categories: LeetCode
tags:
---

Given a non-negative integer, you could swap two digits at most once to get the maximum valued number. Return the maximum valued number you could get.

Example 1:
Input: 2736
Output: 7236
Explanation: Swap the number 2 and the number 7.

Example 2:
Input: 9973
Output: 9973
Explanation: No swap.

Note:
The given number is in the range [0, 10^8]

错误思路: 找到最大值，从左往右遍历，找到比最大值小，并且index 小的值交换


正确思路: 先给每个value 建立index map, 然后遍历数组，遇到第一个，index 靠后 但是 值比当前大，并在数组里的数字，交换


```java
class Solution {
    public int maximumSwap(int num) {
        char[] digits = Integer.toString(num).toCharArray();
        
        int[] buckets = new int[10];
        for (int i = 0; i < digits.length; i++) {
            buckets[digits[i] - '0'] = i;
        }
        
        for (int i = 0; i < digits.length; i++) {
            for (int k = 9; k > digits[i] - '0'; k--) {
                if (buckets[k] > i) {
                    char tmp = digits[i];
                    digits[i] = digits[buckets[k]];
                    digits[buckets[k]] = tmp;
                    return Integer.valueOf(new String(digits));
                }
            }
        }
        
        return num;
    }
}
```

2354989 --> 9354982, 9354289
    
9 8 7 
    
last index of digit


```python
class Solution:
    def maximumSwap(self, num: int) -> int:
        nums = list(str(num))
        valueMap = {}
        
        for i in range(len(nums)):
            valueMap[nums[i]] = i

        for i in range(len(nums)):
            for k in range(9, int(nums[i]), -1):
                index = valueMap.get(str(k), -1)
        
                if index > i:
                    print(k, index, i)
                    nums[index], nums[i] = nums[i], nums[index]
                    return int("".join(nums))
        return num
```
