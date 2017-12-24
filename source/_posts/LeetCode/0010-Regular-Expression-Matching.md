---
title: 0010 Regular Expression Matching
date: 2017-12-20 01:38:42
categories: LeetCode
tags:
---

题目描述:

Implement regular expression matching with support for '.' and '*'.

'.' Matches any single character.
'*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "a*") → true
isMatch("aa", ".*") → true
isMatch("ab", ".*") → true
isMatch("aab", "c*a*b") → true


表示状态 T[i][j] s的前i个字符和p的前j个字符是否匹配。


方程：
T [i] [j]=  T[i-1][j-1]if(p[j]==s[i]‖p[j]==‘•’)
abc abcb*   T[i][j-2]if(p[j]==‘*’‖
abcbb abcb* T[i-1][j]if(p[j]==‘*’UU(p[j-1]==s[i]‖p[j]==‘•’）
初始化：添加同一个dummy node T[o][o]=true
第一行：按照规则来，默认为false；遇到*t[o][j]=t[o][j-2]
第一列：按照规则：全为false
      0  1  2  3  4  5  6
        x  a  *  b    c
0      7            
1    x              
2    a              
3    a              
4    b              
5    y              
6    c              
aa  a  s  aa  a*  ;  ab  ;  *c

每个字符串前加一个字符，使坐标一致.p=“o”+p,s=“o”+s

一开始理解错了（）（（）=>2



