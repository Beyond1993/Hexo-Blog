---
title: 0332-Reconstruct-Itinerary
date: 2017-10-16 07:31:45
categories: LeetCode
tags:
---

JFK --> MUC --> LHR --> SFO --> SJC


```text
JFK   -----> SFO

 ^\  \          ^ /  /          

    \   \ v      /  /v         

           ATL
```
  

 有向图的深度遍历. Map＋ DFS

字典序就是 PriorittyQueue


```text
   1  ------------> 2

 ^\   \               /  /^

    \   \v         v/  /

              3

              |

              v

             4
```


1 -->2, 3

2 --> 3

3 --> 1,2,4



1 --> 2 --> 3  --> 1 ---> 3 ---> 2 ---- 4 回去了 

 
