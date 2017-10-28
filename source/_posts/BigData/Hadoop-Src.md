---
title: Hadoop-技术内幕
date: 2017-09-01 16:11:25
categories: BigData
tags:
---
Hadoop Common: contains libraries and utilities needed by other Hadoop modules
Hadoop Distributed File System (HDFS): a distributed file-system that stores data on the commodity machines, providing very high aggregate bandwidth across the cluster
Hadoop YARN: a resource-management platform responsible for managing compute resources in clusters and using them for scheduling of users' applications
Hadoop MapReduce: a programming model for large scale data processing

# Hadoop Mapreduce
## 第五章 作业提交与初始化过程分析
大致流程
步骤1: 用户使用Hadoop提供的shell命令提交作业
步骤2: JobClient 按照 JobConf 将作业所需的全部文件上传到JobTracker文件系统
步骤3：JobClient 调用 PRC 接口向JobTracker提交作业
步骤4: JobTracker 接收到作业后，将其告知 TaskScheduler, 由TaskScheduler对作业初始化

# Hadoop HDFS
要先了解分布式文件系统，就必须先了解单机的文件系统，分布式文件系统是单机文件系统的拓展。



第一部分

第一章：阅读源代码前的准备
1.3.3 Hadoop源代码组织：
Hadoop-2.8.1-src/
BUILDING.txt             README.txt               hadoop-build-tools       hadoop-dist              hadoop-maven-plugins     hadoop-project-dist      patchprocess
LICENSE.txt              dev-support              hadoop-client            hadoop-hdfs-project      hadoop-minicluster       hadoop-tools             pom.xml
NOTICE.txt               hadoop-assemblies        hadoop-common-project    hadoop-mapreduce-project hadoop-project           hadoop-yarn-project      start-build-env.sh

第二章：MapReduce 设计理念与基本架构



2.4 Hadoop 基本架构

2.4.1 HDFS架构

分布式文件系统和分布式计算框架MapReduce

2.4.2 Hadoop MapReduce 架构

--Client

--JobTracker

--TaskTracker

--Task



2.5 Hadoop MapReduce 作业的生命周期



3.4 非 Java API 解析

3.4.1 Hadoop Streaming 的实现原理

    hadoop streamming 使用标准输入输出流，被运用在aws emr 上





第二部分




