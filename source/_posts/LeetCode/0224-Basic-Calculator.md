---
title: 0224 Basic Calculator
date: 2018-01-26 22:37:15
categories: LeetCode
tags:
---

这题的难点，在于多了一个括号，需要先把括号之前的sign, result 放到stack 里缓存。

遇到 ) 的时候，说明括号里的结果已经算到result 里了，再恢复之前的sign 和 result

```java
public int calculate(String s) {
    Stack<Integer> stack = new Stack<Integer>();
    int result = 0;
    int number = 0;
    int sign = 1;
    for(int i = 0; i < s.length(); i++){
        char c = s.charAt(i);
        if(Character.isDigit(c)){
            number = 10 * number + (int)(c - '0');
        }else if(c == '+'){
            result += sign * number;
            number = 0;
            sign = 1;
        }else if(c == '-'){
            result += sign * number;
            number = 0;
            sign = -1;
        }else if(c == '('){
            //we push the result first, then sign;
            stack.push(result);
            stack.push(sign);
            //reset the sign and result for the value in the parenthesis
            sign = 1;   
            result = 0;
        }else if(c == ')'){
            result += sign * number;  
            number = 0;
            result *= stack.pop();    //stack.pop() is the sign before the parenthesis
            result += stack.pop();   //stack.pop() now is the result calculated before the parenthesis

        }
    }
    if(number != 0) result += sign * number;
    return result;
}
```

```python
class Solution:
    def calculate(self, s: str) -> int:
        str_l = list(s)
        stack = []
        res, num, sign = 0, 0, 1

        for c in str_l:
            if c.isdigit() :
                num = num * 10 + int(c)
            elif c == "+":
                ## 遇到 +, 先算前面的结果，然后把当前sign 改成 1，意味着下一个数字是正数
                res += sign * num
                sign = 1
                num = 0
            elif c == "-":
                ## 这里的sign 是 "-" 之前的result, 这个减号之后的数字，会在下一轮算上
                res += sign * num
                sign = -1
                num = 0
            elif c == "(":
                stack.append(res)
                stack.append(sign)

                res = 0
                sign = 1
            elif c == ")":
                res += sign * num
                num = 0

                ## 先恢复括号前的sign
                res = res * stack.pop()
                ## 再恢复 括号前的 result
                res += stack.pop()
            ## print (res, num)
        
        res +=  sign * num
        return res
```


相比于 227 带加减乘除的，这题可以直接把结果算进result, 227 因为要考虑运算符号的优先级，所以中间结果都需要加入 stack



http://47.113.101.198/2019/08/31/LeetCode/0227-Basic-Calculator-II/
