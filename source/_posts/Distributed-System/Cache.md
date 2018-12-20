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


在系统中的总线广播的size 通常有限制，比如 64kb, 这时候广播的时候就不能直接广播数据了，可以发送一个signature, 表示这条Cache数据作废，等到读到这条数据的时候，相当于cache miss.


还有一个问题就是 如果 cache 的 key 是多个表结合的情况，这样子有一条数据delete之后，可能会出现这条数据的key 的信息不足，这样就不能找到相对应的 data 了.
