---
title: Functional-Programming
date: 2017-12-08 01:41:42
categories: Go
tags:
---

https://www.quora.com/Why-does-functional-programming-favor-concurrency
函数式编程为什么有利于高并发。

https://en.wikipedia.org/wiki/Church%E2%80%93Rosser_theorem

Church-Rosser theorem
首先他的指令是无序的, 又有 lambda calculus


http://www.ruanyifeng.com/blog/2012/04/functional_programming.html

函数式编程不需要考虑"死锁"（deadlock），因为它不修改变量，所以根本不存在"锁"线程的问题。不必担心一个线程的数据，被另一个线程修改，所以可以很放心地把工作分摊到多个线程，部署"并发编程"（concurrency）。
