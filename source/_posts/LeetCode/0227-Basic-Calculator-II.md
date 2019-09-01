---
title: 0227. Basic Calculator II
date: 2019-08-31 23:55:14
categories: LeetCode
tags:
---


加号直接把后面的数字放进来，负号把后面数字取反加进来，乘除把栈顶元素拿出来，和下一个数字运算

```java
class Solution {
    public int calculate(String s) {
       s = "+" + s.replaceAll(" ", "");
       char[] input = s.toCharArray();
       long num = 0;
       Stack<Long> stack = new Stack<>();
       
       for (int i = 0; i < input.length;) {
           char c = input[i];
           if ((c >= '0' && c <= '9') || c == ' ') {
               i++;
           } else if (c == '+') {
               int[] temp = getNumber(input, i);
               i = temp[0];
               num = temp[1];
               stack.push(num);
               num = 0;
           } else if (c == '-') {
               int[] temp = getNumber(input, i);
               i = temp[0];
               num = temp[1];
               stack.push(-num);
               num = 0;
           } else if (c == '*') {
               int[] temp = getNumber(input, i);
               i = temp[0];
               num = temp[1];
               stack.push(stack.pop() * num);
               num = 0;
           } else if (c == '/') {
               int[] temp = getNumber(input, i);
               i = temp[0];
               num = temp[1];
               stack.push(stack.pop() / num);
               num = 0;
           }  
       }
        
       long sum = 0;
       while(!stack.isEmpty()) {
           sum += stack.pop();
       }
       return (int)sum;
    }
    
    private int[] getNumber(char[] input, int i) {
       i = i+1;
       int num = 0;
       while(i < input.length && input[i] >= '0' && input[i] <= '9') {
           num = num * 10;
           num += input[i] - '0';
           i++;
       }
       return new int[]{i, num};
    }
}
```
