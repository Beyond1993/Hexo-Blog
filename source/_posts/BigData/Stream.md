---
title: Stream
date: 2017-12-05 04:09:36
categories: BigData
tags:
---

https://en.wikipedia.org/wiki/Streaming_algorithm
http://www.chinaaet.com/article/3000055608
https://rosona.github.io/post/20151223/

1.1按照描述现象的方式分类

　　按照数据流中数据描述现象的方式，数据流模型可以分为时序(Time Seriel)模型、现金登记(Cash Register)模型和十字转门(Turnstile)模型，其中十字转门模型的适用范围最广，但也是最难处理的。

　　(1)时序模型：将数据流中的每个数据看作独立的对象。

　　(2)现金登记(Cash Register)模型：数据流中的多个数据项增量式地表达某一现象。

　　(3)十字转门(Turnstile)模型：数据流中的多个数据项表达某一现象，随着时间的流逝，该现象可增可减。

　　1.2按照算法所采用的时序范围分类

　　部分算法并不将数据流的数据作为处理对象，而是选取某个时间范围的数据进行处理，按照算法处理数据流时所采用的时序范围，可以将数据流模型分为：快照(Snapshot)模型、界标(Landmark)模型和滑动窗口(Sliding Window)模型，其中界标模型与滑动窗口模型使用得比较普遍。

　　(1)快照模型：处理数据的范围限定在两个预定义的时间戳之间。

　　(2)界标模型：处理数据的范围从某一已知时间到当前时间。

　　(3)滑动窗口模型：处理数据的范围由固定窗口的大小决定，窗口的终点永远是当前时间。


Weighted Randomly Selection

