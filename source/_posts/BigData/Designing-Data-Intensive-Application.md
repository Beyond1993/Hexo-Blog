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

5. Repliation

6. Partitioning

7. Transactions

8. The Trouble with Distributed Systems

9. Consistency and Consensus

Part III.  Derived Data

10. Batch Processing

11. Stream Processing

12. The Future of data Systems






