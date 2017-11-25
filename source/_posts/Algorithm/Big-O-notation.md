---
title: Big-O-notation
date: 2017-11-25 19:20:28
categories: Algorithm
tags:
---

最近在看MTI关于算法导论的公开课，对于一个超级门外汉，一听到这些记法瞬间就懵了，于是只能求助于谷哥。
（1）Big O
如果存在正数c和N，对于所有的n>=N，有f(n)<=c*g(n)，则f(n)=O(g(n))
是不是很抽象？其实这玩意儿说通俗一点就是求一个算法的worst-case，即是一个最坏情况的度量，求的是上界。
（2）Big Omega
如果存在正数c和N，对于所有的n>=N，有f(n)>=c*g(n)，则f(n)=Omega(g(n))
和Big O相反，这个玩意儿是很乐观的，求得是一个算法的最好情况，即下界，即best-case。不过这玩意儿基本上没什么用，因为你总不能跟用户说我这个算法最快的执行时间是3秒吧？万一一不小心执行了三年，用户岂不要气得吐血？
（3）Big Theta
如果存在正数c1，c2和N，对于所有的n>=N，有c1*g(n)<=f(n)<=c2*g(n)，则f(n)=Theta(g(n))
这个记法表示一个算法不会好于XX，也不会坏于XX，太中庸了，没有激情啊。所以也就是求average-case。
（4）little o
对于任意正数c，均存在正数N，对于所有的n>=N，有f(n)<c*g(n)，则f(n)=o(g(n))
（5）little omega
对于任意正数c，均存在正数N，对于所有的n>=N，有f(n)>c*g(n)，则f(n)=omega(g(n))
好了，就简单介绍到这儿吧，以后有什么再做补充。

大 O , 小 o, 大 omega, 小 omega 区别就是有没有可能相等
