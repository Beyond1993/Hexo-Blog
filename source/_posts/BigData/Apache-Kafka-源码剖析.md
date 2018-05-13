---
title: Apache Kafka 源码剖析
date: 2018-01-03 21:06:10
categories: BigData
tags:
---

第1章 快速入门
1.1 Kafka 简介
Apache Kafka 是一种分布式的，基于分布/订阅的消息系统,是由scala 语言编写而成

具有近乎实时性 O(1) 的消息处理能力
支持批量读写消息
支持消息分区
支持在线增加分区，支持在线水平扩展
支持为每个分区创建多个副本
将kafka 作为传统的消息中间件
用作系统中的数据总线 cloud bus
日志收集中心
数据库主从同步工具

基本概念 : 

•  消息

•  Topic& partition &log 
Topic 是针对用户层面的逻辑表达。

•  保留策略
•  Broker
•  副本
•  ISR 集合
•  HW&LEO

分布式系统 常有两种 冗余备份， 同步复制，异步复制

•  Cluster & Controller

•  生产者
•  消费者
•  Consumer Group



第2章 生成者

第3章 消费者

3.1 KafkaConsumer 使用示例

3.2 传递保证语义(Delivery gurantee semantic)

传递保证语义 有三个级别
At most once : 消息可能会丢, 但绝对不会重复传递.
At least once : 消息绝不会丢，但可能会重复传递.
Exactly once : 每条消息只会被传递一次.

要想做到 At exactly once, 要从生产者和消费者两个部分考虑.

生产者不能产生重复消息，消费者不能重复拉取消息.

如何让生产者不会生产重复消息, 有两个方案:
每个分区只有一个生产者写入消息，当出现异常或超时情况时，生产者就要查询此分区的最后一个消息，

为每一个消息添加一个全局唯一主键, 生产者不做其他特殊处理，按照之前分析方法进行重传, 由消费者对消息进行去重,实现 "Eaxctly once"

第4章 Kafka 服务端

第5章 kafka Tool

