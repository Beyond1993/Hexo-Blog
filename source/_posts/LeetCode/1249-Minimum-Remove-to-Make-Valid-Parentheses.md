---
title: 1249 Minimum Remove to Make Valid Parentheses
date: 2020-01-04 19:07:43
categories: LeetCode
tags:
---

Given a string s of '(' , ')' and lowercase English characters. 

Your task is to remove the minimum number of parentheses ( '(' or ')', in any positions ) so that the resulting parentheses string is valid and return any valid string.

Formally, a parentheses string is valid if and only if:

It is the empty string, contains only lowercase characters, or
It can be written as AB (A concatenated with B), where A and B are valid strings, or
It can be written as (A), where A is a valid string.



Example 1:

Input: s = "lee(t(c)o)de)"
Output: "lee(t(c)o)de"
Explanation: "lee(t(co)de)" , "lee(t(c)ode)" would also be accepted.
Example 2:

Input: s = "a)b(c)d"
Output: "ab(c)d"
Example 3:

Input: s = "))(("
Output: ""
Explanation: An empty string is also valid.
Example 4:

Input: s = "(a(b(c)d)"
Output: "a(b(c)d)"


```java
class Solution {
    public String minRemoveToMakeValid(String s) {
        int left = 0;
        int right = 0;
        for (int i = 0; i < s.length(); i++)  
        {
            if (s.charAt(i) == ')') right++;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                if (left < right) {
                   sb.append(c);
                   left++;
                }
            } else if (c == ')') {
                right--; // 消耗一个 right paranthese
                if (left > 0) {
                    left--; // 消耗 left paranthese
                    sb.append(c);
                }
            } else {
                sb.append(c);
            }
            
        }
        return sb.toString();
    }
}
```



