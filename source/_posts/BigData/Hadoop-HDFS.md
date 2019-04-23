---
title: Hadoop-HDFS
date: 2017-10-16 17:39:31
categories: BigData
tags:
---

https://comsince.github.io/download/bigdata/Hadoop_Common_HDFS.pdf

深入解析 Hadoop common 和 HDFS 

[Hadoop 系统架构指南](https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_design.html)

![Architecture](https://hadoop.apache.org/docs/r1.0.4/cn/images/hdfsarchitecture.gif)


一个典型的部署场景是一台机器上只运行一个Namenode实例，而集群中的其它机器分别运行一个Datanode实例。这种架构并不排斥在一台机器上运行多个Datanode，只不过这样的情况比较少见。

要先了解分布式文件系统，就必须先了解单机的文件系统，分布式文件系统是单机文件系统的拓展。



第一部分 环境准备

第一章：源代码环境准备
1.3.3 Hadoop源代码组织：
Hadoop-2.8.1-src/
BUILDING.txt             README.txt               hadoop-build-tools       hadoop-dist              hadoop-maven-plugins     hadoop-project-dist      patchprocess
LICENSE.txt              dev-support              hadoop-client            hadoop-hdfs-project      hadoop-minicluster       hadoop-tools             pom.xml
NOTICE.txt               hadoop-assemblies        hadoop-common-project    hadoop-mapreduce-project hadoop-project           hadoop-yarn-project      start-build-env.sh

## 第二部分 Common 的实现

### 第2章 Hadoop 配置信息处理

### 第3章 序列化与压缩
#### 3.2.1 Hadoop 压缩简介

所有的压缩算法都会考虑时间和空间的权衡，当使用MapReduce 处理压缩文件时，需要考虑压缩文件的可分割性，考虑我们需要对保持在HDFS 上的一个大小为1GB 的文本进行处理，当前HDFS 的数据块大小为64MB情况下，该文件被分为16块，对应的MapReduce 作业会将该文件分为16个输入分片，提供给16个独立的Map 任务进行处理。

如果这个文件是一个1G大小的 gzip 文件，则不能分片. 

### 第4章 Hadoop 远程过程调用
4.1 远程过程调用的基础知识
4.1.1 RPC原理
4.1.2 RPC机制的实现
[RPC和RMI区别](http://blog.duhongguang.com/2016/03/22/translations/DifferenceBetweenRPCandRMI/)
### 第5章 Hadoop 文件系统

4.2 Java动态代理
Hadoop 远程过程调用使用Java动态代理和新输入／输出系统(New Input/Output. NIO)

4.3 Java NIO
4.3.2 Java NIO 基础
1. 缓冲区buffer
2. 通道 channel
3. 选择器 selector

4.4 Hadoop 中远程过程调用
Hadoop 需要精确控制通信中比如连接，超时，缓存等通信细节
4.4.1  利用Hadoop IPC构建简单的分布式系统

### 第5章 Hadoop文件系统
5.1.2 文件系统的实现
1. 块管理
2. 目录管理
3. 存储媒体上的文件系统管理
4. 存储空间管理

Hadoop 重抽象文件系统到，具体文件系统，有很多不同实现，HDFS(分布式文件系统) 只是其中一种
