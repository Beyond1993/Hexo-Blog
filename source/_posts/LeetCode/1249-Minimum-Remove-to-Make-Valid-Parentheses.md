---
title: 1249 Minimum Remove to Make Valid Parentheses
<<<<<<< HEAD
date: 2020-04-08 01:47:56
=======
date: 2020-01-04 19:07:43
>>>>>>> d571013a4275977115b5aa65ea5ba20fb00af641
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
<<<<<<< HEAD
 

Constraints:

- 1 <= s.length <= 10^5
- s[i] is one of  '(' , ')' and lowercase English letters.


这题也很有意思。 先得统计又括号数量。 再扫描一遍.

```java
class Solution {
    public String minRemoveToMakeValid(String s) {
        int left = 0;
        int right = 0;
        
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == ')') {
                right++;
            }
        }
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                if (left < right) {
                    sb.append('(');
                    left++;
                }
            } else if (c == ')') {
                right--; // 消耗 一个 右扩号
                if (left > 0) {
                   // 对应消耗一个左括号
                   left--;
                   sb.append(')');
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
```

