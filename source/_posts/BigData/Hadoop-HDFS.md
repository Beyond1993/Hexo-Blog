---
title: Hadoop-HDFS
date: 2017-10-16 17:39:31
categories: BigData
tags:
---

[Hadoop 系统架构指南](https://hadoop.apache.org/docs/r1.0.4/cn/hdfs_design.html)

![Architecture](https://hadoop.apache.org/docs/r1.0.4/cn/images/hdfsarchitecture.gif)


一个典型的部署场景是一台机器上只运行一个Namenode实例，而集群中的其它机器分别运行一个Datanode实例。这种架构并不排斥在一台机器上运行多个Datanode，只不过这样的情况比较少见。
