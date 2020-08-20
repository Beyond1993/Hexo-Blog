---
title: 0067 Add Binary
date: 2020-05-09 08:46:02
categories: LeetCode
tags:
---

Given two binary strings, return their sum (also a binary string).

The input strings are both non-empty and contains only characters 1 or 0.

Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


简洁版:
```java
class Solution {
    public String addBinary(String a, String b) {
        int i = a.length() - 1;
        int j = b.length() - 1;
        StringBuilder sb = new StringBuilder();
        int carry = 0;
        int sum = 0;
        while(i >= 0 || j >= 0) {
            int num1 = i < 0 ? 0 : a.charAt(i) - '0';
            int num2 = j < 0 ? 0 : b.charAt(j) - '0';
            sum = num1 + num2 + carry; //1 + 1 + 1
            sb.append(sum % 2);
            carry = sum / 2;  
            i--;
            j--;
        }
        if (carry == 1) {
            sb.append('1');
        }
        return sb.reverse().toString();
    }
}
```



最优解
```java
class Solution {
    public String addBinary(String a, String b) {
        int i = a.length() - 1;
        int j = b.length() - 1;
        StringBuilder sb = new StringBuilder();
        int carry = 0;
        int sum = 0;
        while(i >= 0 && j >= 0) {
            int num1 = a.charAt(i) - '0';
            int num2 = b.charAt(j) - '0';
            sum = num1 + num2 + carry; //1 + 1 + 1
            sb.append(sum % 2);
            carry = sum / 2;  
            i--;
            j--;
        }
        while (i >= 0) {
            sum = carry + (a.charAt(i) - '0');
            //System.out.println(sum);
            sb.append(sum % 2);
            carry = sum / 2;
            i--;
        }
        while(j >= 0) {
            sum = carry + (b.charAt(j) - '0');
            sb.append(sum % 2);
            carry = sum / 2;
            j--;
        }
        if (carry == 1) {
            sb.append('1');
        }
        return sb.reverse().toString();
    }
}
```
