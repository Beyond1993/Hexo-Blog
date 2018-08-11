---
title: Cache
date: 2018-06-06 21:15:28
categories: Distributed-System
tags:
---

Cache 的作用有两个

1. reuse
2. pass the data


最近在给系统加缓存

关于缓存一致性问题，一种方法是简单的用 Updater 直接广播 更新的值到 Cache

还有就是之前上Architecture的时候专门讲到的cache 一致性原理。

但是这些方法共同的特点是Cache 之间是不相互通信的。 要么保持和数据库一致，要么保持和主存一致

cache 一般是不能保持强一致性的，确实有cache 的数据不是最新的这种情况，但是很多情况下这种是可以容忍的
