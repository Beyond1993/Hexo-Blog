---
title: BigData-Yarn
date: 2017-08-24 17:08:58
categories: BigData
tags:
---

Yarn 是一个通用资源管理系统,Hadoop 2.0 打造一个以Yarn为核心的生态系统
Yarn 是弹性计算平台的代表

MRv2通过将资源管理器和应用程序管理两部分剥离开，分别由Yarn和ApplicationMaster负责,
其中,Yarn专管资源管理和调度，Application则负责与具体应用程序相关的任务切分，任务调度和容错等.

Yarn 的基本设计思想是将MRv1中的JobTracker拆成两个独立服务
ResourceManager:负责整个系统的资源管理和分配
ApplicationMaster:负责单个应用程序的管理

注:[MPI(Message Passing Interface)](https://en.wikipedia.org/wiki/Message_Passing_Interface)

```text                        
                            + Scheduler
     +ResourceManager(RM)---+ 
     |                      + Applications Manager(ASM)
Yarn +ApplicationMaster(AM)
     |
     +NodeManager(NM)
     |
     +Container
```

## 第二部分 YARN 核心设计篇
### YARN基础库

YARN主要的基础库:
Protocol BUffers: 序列化，反序列化
Apache Avro: RPC框架
RPC:
服务库和事件库:YAEN将所有对象服务化，以便统一管理，服务之间采用事件机制通信，不使用函数调用
状态机:YARN采用有限状态机描述一些对象的状态以及状态间的转移。

序列化:

RPC:
RPC通信模型:
同步：
异步：

通信模块
Stub模块
调度程序
客户程序/服务过程



Hadoop RPC框架四层:
序列化层
函数调用层
网络传输层
服务器端处理框架

hadoop 采用了基于事件驱动的Reactor设计模式

