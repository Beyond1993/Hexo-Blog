---
title: 从PAXOS到ZOOKEEPER分布式一致性原理与实践
date: 2017-11-22 02:13:45
categories: Distributed-System
tags:
---

第1章 分布式架构

第2章 一致性协议

三阶段提交是将二阶段提交的“提交事务请求”过程一分为二, canCommit, PreCommit 这样以来，通过preCommit, 解决了参与者的阻塞问题。
不用等condinator发出，commit 指令，自己就可以预提交了.

参与者引入超时机制，这样就没有condinator 单点故障等待问题.


第3章 Paxos的工程实践

第4章 
