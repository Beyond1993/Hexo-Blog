---
title: 0008 String to Integer (atoi)
date: 2017-12-26 01:17:00
categories: LeetCode
tags:
---

Implement atoi to convert a string to an integer.

Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.

Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.

```java
public int myAtoi(String str) {
    int index = 0, sign = 1, total = 0;
    //1. Empty string
    if(str == null || str.isEmpty()) return 0;

    //2. Remove Spaces
    while(str.charAt(index) == ' ' && index < str.length())
        index ++;

    //3. Handle signs
    if(str.charAt(index) == '+' || str.charAt(index) == '-'){
        sign = str.charAt(index) == '+' ? 1 : -1;
        index ++;
    }

    //4. Convert number and avoid overflow
    while(index < str.length()) {
        int digit = str.charAt(index) - '0';
        if(digit < 0 || digit > 9) break;

        //check if total will be overflow after 10 times and add digit
        if((Integer.MAX_VALUE - digit)  / 10 < total)
            return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;

        total = 10 * total + digit;
        index ++;
    }
    return total * sign;
}
```
这题的难点还是在于判断溢出。因为有一句 total = 10 * total + digit;

其实应该是两重判断

10 * total < Integer.MAX_VALUE ==> tatal < Integer.MAX_VALUE;

10 * total + digit < Integer.MAX_VALUE  ==> total < (Integer.MAX_VALUE - digit) / 10


