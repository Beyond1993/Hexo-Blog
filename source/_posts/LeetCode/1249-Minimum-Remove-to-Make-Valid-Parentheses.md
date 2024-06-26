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
 

Constraints:

- 1 <= s.length <= 10^5
- s[i] is one of  '(' , ')' and lowercase English letters.


这题也很有意思。 先得统计右括号数量。 再扫描一遍.

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

```python
class Solution:
    def minRemoveToMakeValid(self, s: str) -> str:
        l, r = 0, 0
        lst = list(s)
        for c in lst:
            if c == ')':
                r += 1
        res = []
        for i in range(len(lst)):
            c = lst[i]
            if c =='(': # 遇到左括号，并且数量小于右括号，直接加到结果
                if l < r:
                    res.append('(')
                    l += 1
            elif c == ')': # 遇到右括号，先消除，如果还有多余左括号
                r -= 1
                if l > 0: # l > 0 意味着之前有个一个左括号加到结果里，所以可以加一个右括号
                    l -= 1
                    res.append(')')
            else:
                res.append(c)
        
        return "".join(res)

```

