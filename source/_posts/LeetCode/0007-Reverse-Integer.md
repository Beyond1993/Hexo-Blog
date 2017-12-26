---
title: 0007 Reverse Integer
date: 2017-12-25 23:56:56
categories: LeetCode
tags:
---

题目描述:

Given a 32-bit signed integer, reverse digits of an integer.

Example 1:

Input: 123
Output:  321
Example 2:

Input: -123
Output: -321
Example 3:

Input: 120
Output: 21
Note:
Assume we are dealing with an environment which could only hold integers within the 32-bit signed integer range. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

这题本身的逻辑不难，就是 %10, /10 不断把最后的结果放到新的result 里。
有意思的是这题的边界判断，
正常的判断就是 newResult 不能越界。

所以 newResult <= Integer.MAX_VALUE 



```java
public int reverse(int x) {
    int result = 0;
    int sign = x < 0 ? -1 : 1;
    x = Math.abs(x);
    while (x != 0)
    {
        int tail = x % 10;
        int newResult = result * 10 + tail;
        if (Integer.MAX_VALUE / 10 < result || (Integer.MAX_VALUE - x % 10) < result * 10) {
            return 0;
        }
        result = newResult;
        x = x / 10;
    }

    return sign * result;
}

```

