---
title: 0382 Linked List Random Node
date: 2019-09-18 01:08:50
categories: LeetCode
tags:
---

水塘抽样


连续N 个数，

第一个进来, 抽取第一个数的概率是 1

第二个数进来，抽取第二个数 rand(2), 第二个数抽中概率是 1/2， 第一个数不被替换的概率是 1 * 1/2

第三个数进来，抽中第三个数 rand(3) , 1/3, 前两个数不被替换的概率是 1 * 1/2 * 2/3 = 1/3, 1/2 * 2/3  = 1/3  

1 * 1 / 2 * 2 /3 * 3/4 = 1/4, 1/2 * 2/3 * 3/4 = 1/4, 1/3 * 3/4 = 1/4, 1/4

水塘抽样公式:

random.nextInt(count) == count

or 

random.nextInt(count) == 0


