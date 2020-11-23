---
title: 1190 Reverse Substrings Between Each Pair of Parentheses
date: 2020-11-23 09:22:55
categories: LeetCode
tags:
---

You are given a string s that consists of lower case English letters and brackets. 

Reverse the strings in each pair of matching parentheses, starting from the innermost one.

Your result should not contain any brackets.

Example 1:

Input: s = "(abcd)"
Output: "dcba"
Example 2:

Input: s = "(u(love)i)"
Output: "iloveu"
Explanation: The substring "love" is reversed first, then the whole string is reversed.
Example 3:

Input: s = "(ed(et(oc))el)"
Output: "leetcode"
Explanation: First, we reverse the substring "oc", then "etco", and finally, the whole string.
Example 4:

Input: s = "a(bcdefghijkl(mno)p)q"
Output: "apmnolkjihgfedcbq"

```java
class Solution {
    public String reverseParentheses(String s) {
        
        Stack<Integer> stack = new Stack();
        char[] arr = s.toCharArray();
        
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == '(') {
                stack.push(i);
            }
        }
        
        while(!stack.isEmpty()) {
            int index = stack.pop();
            int next = index;
            while (arr[next] != ')') {
                next++;
            }
            s = reverse(s, index, next);
        }     
        
        return s;
    }
    
    
    public String reverse(String s, int i, int j) {
        if (s == null || s.isEmpty()) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        
        for (int k = j - 1; k > i; k--) {
            sb.append(s.charAt(k));
        }
        
        return s.substring(0, i) + sb.toString() + s.substring(j+1);
    }
}
```


