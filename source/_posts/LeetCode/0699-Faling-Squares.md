---
title: 0699 Faling Squares
date: 2019-05-11 18:38:49
categories: LeetCode
tags:
---

下落的方块。 相似的题目. 

715 Range Module
218 The Skyline Problem

暴力解 (N^2)

用map 或者 segment tree 优化。

```txt
[[1, 2], [2, 3], [6, 1]]
     1-6:2  
     /   \
   1:2, 2-6:2     
         /  \     
       2:2 3-5:5         
             \          
            6:1

```
