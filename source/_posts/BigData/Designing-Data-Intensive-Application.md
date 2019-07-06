---
title: Designing-Data-Intensive-Application
date: 2017-11-29 22:02:30
categories: BigData
tags:
---

Part I. Foundations of Data Systems
## 1. Reliable, Scalable, and Maintainable Applications

• Store data so that they, or another application, can find it again later (databases)
• Remember the result of an expensive operation, to speed up reads (caches)
• Allow users to search data by keyword or filter it in various ways (search indexes)
• Send a message to another process, to be handled asynchronously (stream pro‐ cessing)
• Periodically crunch a large amount of accumulated data (batch processing)

Redis message queues key-value storage cache
Kafka message queues database-like


我们来构建一个简单的系统:
![](/images/simple-system.png)


* How do you ensure that the data remains correct and complete, even when things go wrong internally? 
* How do you provide consistently good performance to clients, even when parts of your system are degraded? 
* How do you scale to handle an increase in load? 
* What does a good API for the service look like?

先不急着回答上面的问题, 我们看看一个好的系统，应该有哪些特性

Reliability 正确
The system should continue to work correctly (performing the correct function at the desired level of performance) even in the face of adversity (hardware or soft‐ ware faults, and even human error).
Scalability 增长
As the system grows (in data volume, traffic volume, or complexity), there should be reasonable ways of dealing with that growth.
Maintainability 好用
Over time, many different people will work on the system (engineering and oper‐ ations, both maintaining current behavior and adapting the system to new use cases), and they should all be able to work on it productively.

### Reliability

### Scalability

### Maintainbility
Operability: Making Life Easy for Operations
Simplicity: Managing Complexity
Evolvability: Making Change Easy
 
关于系统设计面试中，很多时候关注了 前两个 特性 ，而忘记了维护性。
OOD mirco service mvc 等设计模式，都体现了这种特性。 解耦合。 database可以自动sharding和rebanlancing
持续集成，持续交付，持续部署
## 2. Data Models and Query Languages

## 3. Storage and Retrieval

## 4. Encoding and Evolution


Part II Distributed Data

## 5. Repliation

## 6. Partitioning

## 7. Transactions

## 8. The Trouble with Distributed Systems

## 9. Consistency and Consensus

Part III.  Derived Data

### 10. Batch Processing
首先我们要区分三种不同的系统:

Service(online system)

Batch processing system(offline systems)
Hadoop 的 map reduce
其实 map reduce的架构是一个非常基础，low-level 的编程模型，虽然现在看来已经有些过时了，但是它为大规模计算从单机到集群迈出了里程碑式的一步

Stream processing systems(near-real-time systems)

流处理是基于 online 和 offline/batch 处理之间的处理。

#### Bath Processing with Unix Tools
分布式系统的原理，很多都是来自单机的unix 哲学，学好unix 才是学好分布式的关键

Simple Log Analysis

```text
cat /var/log/nginx/access.log |
      awk '{print $7}' |
      sort             |
      uniq -c          |
      sort -r -n       |
      head -n 5
```

其实有时候在处理gigabytes 的文件时，简单的awk,sed,grep,sort,uniq xargs 就可以在几分钟之内搞定。

The Unix Philosophy

为什么linux 下的不同group 写的小工具  可以做到无缝对接，因为 linux 提供了最基本的三大特性。 

**a uniform interface** 

**Separation of logic and wiring** wiring是装电线的意思。这里应该是缝合

这种特性同样适合于大型分布式系统。

其实像stdin stdout 这种在hadoop streaming 里也有广泛的应用

**Transparency and experimentation**
输入文件是immutable的
整个pipeline 可以任意终止
一个stage 的 output 作为另一个stage 的 input

想想spark 的任务迭代，是不是就是这个样子？

#### MapReduce and Distributed Filesystems
这么来看，MapReduce 有点像一个大型的分布式的Unix tools
MapReduce Job Execution
Reduce-Side Joins and Grouping
Map-Side Joins
The Output of Batch Workflows
Comparing Hadoop to Distributed Databases
Beyond MapReduce

MapReduce 框架的原理很简单，但是实际使用却是件很复杂的事，比如各种Join 操作就很难实现，像Pig, Hive, Cascading, Crunch这些high level的框架就应运而生

Materialization of Intermediate State
实例化。

MapReduce job 之间是相互独立的，一个job 必须要要等它依赖的job完成才可以继续执行。

这样子的话，我们就要把各个中间结果public 到一个公共的分布式文件系统下。

如果这个中间结果被多个jobs同时使用，还可以接受，但是如果这个job 的结果只是针对某一个job, 那么这种方式就显的很低效了。
(突然想起来之前写的pipeline, 存各种无用的信息到s3,效率低不说，总感觉很蛋疼)
所以就出现了 stream 处理。

好，我们来看看Unix pipe 是怎么做的

• 在Unix 管道中，所有的管道是同时运行的，每个stage 产生的数据，只要计算出一个，就直接传给下一个stage. 有没有想到指令流水线？ 原理都是一样的。
• Mappers 很多时候都是多余的，完全可以把Mapper 里的数据，直接写到上一个reducer里
then reducers could be chained together directly, without interleaving with mapper stages。
• 更蛋疼的是，我们在distributed filesystem 里存这些materailization的中间结果，必然会有多处备份，但这只是个中间结果啊。有必要吗？

Dataflow engines

为了解决上述三个问题：新型的计算引擎就千呼万唤始出来了。

最出名的三个货： Spark, Tez, Flink

虽然这三个家伙各有姿色，但是他们有一个共同的特性：
they handle an entire workflow as one job, rather than breaking it up into independent subjobs.

除此之外, 传统的Map Reduce 的并行，体现在将input 分成 partition，然后各自调用单线程的function，再将这个function的输入作为输出。这样子还是一中类似于输入输出的简单模型。

但是在spark中，我们是直接给数据集加operation, 这就是为什么我们称RDD 是一个类（虽然源码实现中，确实也是这样子的)

Spark 里的operation 分两种，一种是Transforamtion, 另一种是Action
Fault tolerance
容错，在MapReduce 的容错系统中，一个坏了，直接取备份就好
但是spark 是直接记录了这些数据产生的来源。失败了，就重试一次

11. Stream Processing

12. The Future of data Systems






