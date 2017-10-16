---
title: Priority-Queue
date: 2017-10-16 06:32:48
categories: C/C++
tags:
---
它的模板声明带有三个参数，priority_queue<Type, Container, Functional>　Type 为数据类型， Container 为保存数据的容器，Functional 为元素比较方式。

Container 必须是用数组实现的容器，比如 vector, deque 但不能用 list.　



STL里面默认用的是 vector. 比较方式默认用 operator< , 所以如果你把后面俩个参数缺省的话，优先队列就是大顶堆，队头元素最大。



默认最大堆

priority_queue<int> qi;



最小堆

priority_queue<int, vector<int>, greater<int> >qi2;




