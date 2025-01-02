---
title: 0036 Valid Sudoku
date: 2018-01-09 01:28:07
categories: LeetCode
tags:
---


数独是否有解，对于同一行，同一列的情况，比较好判断，每一行，每一列都搞一个hashmap, 
对于一个 box 的id,

 
idx = (r // 3) * 3 + c // 3

比如 

