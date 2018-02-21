---
title: LeetCode-Palindrome-Problem
date: 2017-08-23 00:45:42
categories: LeetCode-Index
tags:
---
回文是一个很有意思的专题
包含了, Integer, String, Array, LinkedList

## leetcode 5 Longest Palindromic Substring
这题有暴力解法，奇偶讨论法，动态规划法

## leetcode 9 Palindrome Number 必背题
判断一个Integer是否回文，不能用额外空间
取一半，看是否相等

```java
rev = 0;
while (x > rev) {
    rev = rev * 10 + x % 10;
    x = x / 10;
}
return (x == rev || x == rev / 10)
```
## 125 Valid Palindrome
two pointers, character isLetterOrDigit() toLowercase()

## 131 Palindrome Patitioning 回文分割， 回溯

## 132 Palindrome Patitioning 回文分割,DP, 最少次数

## 214 Shortest Palindrome
在原有基础上构造最短回文
暴力解法: 从第一个字符开始找最长回文串，将剩下的翻转
KMP 的核心就是要解决，字串不匹配后的回溯问题
KMP 是在匹配失败时，主串不回溯，而只需要模式串按照next数组回溯
next数组只和模式串有关，是其自身特性
求next函数:next[i] 表示 substring(0,i)的真前缀，真后缀最长公共长度
      a b c d a b c a
      0 1 2 3 4 5 6 7
next: 0 0 0 0 1 2 3 1

s + "#" + rever_s 就变成了写一个KMP里的失败函数


