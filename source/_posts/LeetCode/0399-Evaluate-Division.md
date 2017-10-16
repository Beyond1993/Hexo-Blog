---
title: 0399-Evaluate-Division
date: 2017-10-16 07:21:35
categories: LeetCode
tags:
---

Equations are given in the format A / B = k, where A and B are variables represented as strings, and k is a real number (floating point number). Given some queries, return the answers. If the answer does not exist, return -1.0.

Example:
Given a / b = 2.0, b / c = 3.0. 
queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ? . 
return [6.0, 0.5, -1.0, 1.0, -1.0 ].

The input is: vector> equations, vector& values, vector> queries, where equations.size() == values.size(), and the values are positive. This represents the equations. Return vector.

According to the example above:

equations = [ ["a", "b"], ["b", "c"] ],
values = [2.0, 3.0],
queries = [ ["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"] ].


The input is always valid. You may assume that evaluating the queries will result in no division by zero and there is no contradiction.



根据已有的规则，看哪些表达式能推导出来。



第一想法就是替换: a / b = 2.0 ==> < 'a', <'b, 2.0'>    < 'b' , 'a, 0.5'>

再一个个去遍历。
