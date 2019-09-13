---
title: 0394 Decode String
date: 2019-09-13 05:01:21
categories: LeetCode
tags:
---

没有遇到 [ 的字母 就直接加入结果集, 遇到 [ 说明是一个子问题. 所以要把buffer 重新置零.



```java
class Solution {
    public String decodeString(String s) {
        Stack<Integer> countStack = new Stack<>();
        Stack<String> stringStack = new Stack<>();
        int num = 0;
        int index = 0;
        int n = s.length();
        String buffer = "";
        while (index < n) {
            char c = s.charAt(index);
            if ( '0' <= c  && c <= '9') {
                num = 0;
                while('0' <= c  && c <= '9') {
                    num = num * 10 + (c - '0');
                    c = s.charAt(++index);
                }
                countStack.push(num);
            } else if (c == '[') {
                stringStack.push(buffer);
                buffer = "";
                index++;
            } else if (c == ']') {
                String lastLevel = stringStack.pop();
                int lastNum = countStack.pop();
                String temp = "";
                for (int i = 0; i < lastNum; i++) {
                    temp += buffer;
                }
                buffer = lastLevel + temp;
                index++;
                
            } else {
                buffer += s.charAt(index++);
            }
        }  
        return buffer;
    }
}
```
