---
title: Interview-Google
date: 2017-11-17 06:11:08
categories: Interview
tags:
---

OA:

K 


Onsite : 
Design an algorithm to figure out if someone has won a game of tic-tac-toe

参考 cc189 的 16.4

205 follow up

branch of string stirng --> String [] strings --> preprocess strings one time

String is large
key is string length, 
Map<integer, List<String>>, 

better
transitive, 传递性

Union Find

159 

Onsite Interview:
https://leetcode.com/problems/isomorphic-strings
https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters
https://leetcode.com/problems/longest-substring-with-at-most-k-distinct-characters
https://leetcode.com/problems/lru-cache


其实第三题without-repeating-characters, 就是at-most-one-characters


https://en.wikipedia.org/wiki/Mastermind_(board_game)

weight random


Google 题目 1万台机器，1亿个数字，找第K大的数字。如果这些数字在月球上？

最简单的是每台机器选取K个，传回地球，如果K很大的情况下，每个machine 先取第K大
再在取最小的k, 作为threthold

反复迭代

每台机器也可以返回 小鱼等于 K 的 nums, max, min value

