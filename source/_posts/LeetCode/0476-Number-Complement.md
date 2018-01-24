---
title: 0476 Number Complement
date: 2018-01-24 04:38:35
categories: LeetCode
tags:
---

Given a positive integer, output its complement number. The complement strategy is to flip the bits of its binary representation.

Note:
The given integer is guaranteed to fit within the range of a 32-bit signed integer.
You could assume no leading zero bit in the integer’s binary representation.
Example 1:
Input: 5
Output: 2
Explanation: The binary representation of 5 is 101 (no leading zero bits), and its complement is 010. So you need to output 2.
Example 2:
Input: 1
Output: 0
Explanation: The binary representation of 1 is 1 (no leading zero bits), and its complement is 0. So you need to output 0.


```java
public int findComplement(int num) {
  return ~num & ((Integer.highestOneBit(num) << 1) - 1);
}
```

阿鲁哈说，这不是正经的补码，只是求最低几位的不嘛。所以后面一部分是做了一个 00001111 类似的 mask
