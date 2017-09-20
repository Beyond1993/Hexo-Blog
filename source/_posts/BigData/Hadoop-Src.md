---
title: Hadoop-Src
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

