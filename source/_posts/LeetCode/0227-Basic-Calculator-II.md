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

这个python 解法里有个巧思, 就是s[i] 遇到当前的 operator, 实际上算的operator 不是 当前s[i], 二是上一次的operator

```python
class Solution:
    def calculate(self, s: str) -> int:
        stack = []
        operator = '+'
        num = 0 

        s = s.strip()
        for i in range(len(s)):
           ## print('i', i, 'stack', stack, 'num', num)
            if s[i] == '':
                continue
            if s[i].isdigit():
                num = num * 10 + int(s[i])
            if s[i] in ['+', '-', '*', '/'] or (i==len(s)-1):
                if operator == '+':
                    stack.append(num)
                    # print('here', stack)

                elif operator == '-':
                    # print('i', i, '*', '-', stack, num)
                    stack.append(-num)

                elif operator == '*':
                    # print('i', i, '*', stack, stack[-1]*num)
                    stack.append(stack.pop()*num)
                    # print(stack)

                elif operator == '/':
                    print(int(stack[-1]/num))
                    stack.append(int(stack.pop()/num))
                else:
                    stack.append(num)
                # stack.append(num)
                operator = s[i]
                num = 0
            # print('i', i, 'stack', stack)
        stack.append(num)

        # print(stack)
        res = 0
        for n in stack:
            res += n 
        return res
```


