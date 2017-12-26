---
title: Algorithms-Robert-Sedgewick
date: 2017-12-25 19:19:29
categories: Algorithm
tags:
---

https://algs4.cs.princeton.edu/code/

之前一直是通过leetCode 来学习算法，管中窥豹，总不能提纲挈领.

## 第1章 基础
1.1 基础编程模型

1.2 数据抽象

1.3 背包队列和栈

1.4 算法分析

1.5 案例研究 ：union-find

## 第2章 排序

## 第3章 查找

## 第4章 图
图论应用在 地图，网页信息，电路，任务调度，商业交易，配对，计算机网络，软件，社交关系

|应用|节点|连接|
|----|:---|:--|
|地图|十字路口|公路|
|网络内容|网页|超链接|
|电路|元器件|导线|
|任务调度|任务|限制条件|
|商业交易|客户|交易|
|配对|学生|申请|
|计算机网络|网络|物理连接|
|软件|方法|调用关系|
|社交网络|人|友谊关系|

学习基本的四张图 **无向图(简单连接)，有向图，加权图，加权有向图**

### 4.1 无向图

含有平行边的称为多重图，没有平行边或者自环的称为简单图，这样就可以用两个点表示一条边


在LeetCode 中，用邻接表表示一张图
```java
class UndirectedGraphNode {
      int label;
      List<UndirectedGraphNode> neighbors;
      UndirectedGraphNode(int x) { 
          label = x; 
          neighbors = new ArrayList<UndirectedGraphNode>(); }
  };
```




## 第5章 字符串

 


