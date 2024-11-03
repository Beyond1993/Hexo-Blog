---
title: 306 Additive Number
date: 2024-10-25 08:07:47
categories: LeetCode
tags:
---

An additive number is a string whose digits can form an additive sequence.

A valid additive sequence should contain at least three numbers. Except for the first two numbers, each subsequent number in the sequence must be the sum of the preceding two.

Given a string containing only digits, return true if it is an additive number or false otherwise.

Note: Numbers in the additive sequence cannot have leading zeros, so sequence 1, 2, 03 or 1, 02, 3 is invalid.

 

Example 1:

Input: "112358"
Output: true
Explanation: 
The digits can form an additive sequence: 1, 1, 2, 3, 5, 8. 
1 + 1 = 2, 1 + 2 = 3, 2 + 3 = 5, 3 + 5 = 8
Example 2:

Input: "199100199"
Output: true
Explanation: 
The additive sequence is: 1, 99, 100, 199. 
1 + 99 = 100, 99 + 100 = 199

这题的难点在于数字长度是不固定的。

```python
class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        length = len(num)
        
        # Try all possible pairs of lengths for the first two numbers
        for i in range(1, (length // 2) + 1):  # Length of the first number
            for j in range(1, length - i):  # Length of the second number
                # Check leading zeros
                num1 = num[:i]
                num2 = num[i:i + j]
                if (len(num1) > 1 and num1[0] == '0') or (len(num2) > 1 and num2[0] == '0'):
                    continue
                
                # Initialize the sequence
                if self.isValidAdditive(int(num1), int(num2), num[i + j:]):
                    return True
        
        return False
    
    def isValidAdditive(self, num1: int, num2: int, remaining_str: str) -> bool:
        if not remaining_str:  # If there's nothing left, the sequence is valid
            return True
        
        sum_ = num1 + num2
        sum_str = str(sum_)
        
        # Check if the remaining string starts with the sum
        if not remaining_str.startswith(sum_str):
            return False
        
        # Continue with the next numbers
        return self.isValidAdditive(num2, sum_, remaining_str[len(sum_str):])
```

time complexity: 上面两层for 循环是 O(n^2), isAdditive 调用的递归深度是 O(n), O(n^3)
space complexity: 递归调用栈是 O(n) 

```python
class Solution:
    def isAdditiveNumber(self, num: str) -> bool:
        length = len(num)

        def isAdditive(num1, num2, remain_str):
            if not remain_str: return True
            Sum = num1 + num2
            sum_str = str(Sum)

            if not remain_str.startswith(sum_str):
                return False

            return isAdditive(num2, Sum, remain_str[len(sum_str):])

        def isInValidNum(num):
            return len(num) > 1 and num[0] == '0'

        for i in range(1, length // 2 + 1): ## num1 length
            for j in range (1, length - i): ## num2 length
                num1 = num[:i]
                num2 = num[i: i + j]
                if isInValidNum(num1) or isInValidNum(num2):
                    continue
                remain_str = num[i + j:]
                if isAdditive(int(num1), int(num2), remain_str):
                    return True
        return False
```
