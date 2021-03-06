---
title: Paxos-Algorithm
date: 2017-09-26 22:54:28
categories: Distributed-System
tags:
---

Paxos算法是大名鼎鼎的Zookeeper中采用的选举Leader的算法，事实上，在涉及到分布式系统的一致性的时候，就只有一种算法，那就是Paxos.

首先来看，Paxos是为了解决什么问题：

Paxos 算法解决的问题是一个分布式系统如何就某个值（决议）达成一致。一个典型的场景是，在一个分布式数据库存储中，如果各节点的初始状态一致，每个节点执行相同的操作序列，那么他们最后能得到一个一致的状态。为保证每个节点执行相同的命令序列，需要在每一条指令上执行一个“一致性算法”以保证每个节点看到的指令一致。一个通用的一致性算法可以应用在许多场景中，是分布式计算中的重要问题。因此从20世纪80年代起对于一致性算法的研究就没有停止过。节点通信存在两种模型：共享内存（Shared memory）和消息传递（Messages passing）。Paxos 算法就是一种基于消息传递模型的一致性算法。

本文的实现参考了LynnCui在知乎上的文章：https://zhuanlan.zhihu.com/p/21438357

http://www.cnblogs.com/endsock/p/3480093.html
