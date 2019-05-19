---
title: 0065 Valid Number
date: 2019-05-18 20:33:46
categories: LeetCode
tags:
---

Validate if a given string can be interpreted as a decimal number.

Some examples:
"0" => true
" 0.1 " => true
"abc" => false
"1 a" => false
"2e10" => true
" -90e3   " => true
" 1e" => false
"e3" => false
" 6e-1" => true
" 99e2.5 " => false
"53.5e93" => true
" --6 " => false
"-+3" => false
"95a54e53" => false

Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one. However, here is a list of characters that can be in a valid decimal number:

Numbers 0-9
Exponent - "e"
Positive/negative sign - "+"/"-"
Decimal point - "."
Of course, the context of these characters also matters in the input.



这题还算是挺难的， case 过多，不好分析。


一开始我的想法。

case1:  ‘0’ ~ ‘9’

case2:  ‘.’

Case3: ‘+’, ‘-‘

Case4: ‘.’

Case5: ‘e’

Case6: ‘a’ ~ ‘d’, ‘f’ ~’z’

但是这样分析问题非常trick. 

当我在遇到一个point, ‘e’,  ‘+’,  ‘-‘ 时，并不是直接。

比如00.2 001.2 
而是用四个变量， 处理这些condition 


numberSeen
PointSeen
eSeen
numberAfterE

how to handle '+', '-'

if index of '+' or '-' is not zero && last char is not e. return false;

