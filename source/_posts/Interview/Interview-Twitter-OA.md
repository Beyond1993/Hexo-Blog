---
title: Interview-Twitter-OA
date: 2017-08-20 03:24:05
categories: Interview
tags:
---
http://www.1point3acres.com/bbs/thread-209018-1-1.html
http://www.1point3acres.com/bbs/thread-169507-1-1.html
http://www.1point3acres.com/bbs/thread-208310-1-1.html

Twitter 发来OA, 先把题目过一遍.

1. longest subarray sum less than k
   input: int array , L
   output: length of subarray (sum <= K)
   example:
   array = [1,2,3], K = 4
   sum <= 4 的有，[1],[2],[3],[1,2], len([1,2]) = 2,so return 2

2. hacking time
   Original message: Hi, this is an example
   Example key: 4071321
   Encrypted message: Li,ailu jw au facntll
   每个字母按照数字旋转，保留大小写，空格，特殊字符

3. acme rotations
   [Lexicographically minimal string rotation](https://en.wikipedia.org/wiki/Lexicographically_minimal_string_rotation)
   suffix array?
   [anwser](https://github.com/marioyc/Online-Judge-Solutions/blob/master/SPOJ/Classical/3605%20-%20Minimum%20Rotations.cpp)
   最小字典序旋转字符串，是归一化同构字符串的常见方法，归一化后的字符串，保留了结构信息，便于比较
   input : baabccd , baabccd-> aabccd 旋转一次
output : 1
input : anadama , anadama - > nadamaa -> adamaan -> damaana -> amaannad -> maanada - > aanadam ,
output 6
