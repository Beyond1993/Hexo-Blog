---
title: Apache Spark 源码剖析
date: 2017-12-19 00:35:23
categories: BigData
tags:
---

## 第一部分 Spark 概述
### 第1章 初识Spark
#### 1.1 大数据和Spark

##### 1.1.1 大数据的由来
主要还是互联网用户的飞速发展

##### 1.1.2 大数据的分析
一台机器处理不了

##### 1.1.3 Hadoop
Google的三驾马车
MapReduce 计算框架 
GFS 数据存储  
BigTable NoSQL 始祖。

##### 1.1.4 Spark 简介
在Hadoop 的整个生态系统中，Spark 和 MapReduce 在同一个层级，即主要解决分布式分布式计算框架问题.
与MapReduce 提供的编程模型相比，Spark 具有如下两个鲜明的特点: 
(1) 计算更为快速，速度可以提高10到100倍不等
(2) 计算过程中，如果某一节点出现问题，事件重演的代价远远小于MapReduce

Spark 所要涉及的知识领域：

(1) 分布式并行处理，集群管理
(2) 高可靠的两重含义，一是服务的有效性，二是计算结果的准确性
(3) 高性能计算在可以接受的时间内完成

Streaming: 流数据的实时处理
SQL      : 类SQL的数据分析 
GraphX   : 常用的图计算    
MLLib    : 机器学习算法    

Spark 和 Hadoop 有如下关联
(1) Spark 和 Hadoop 的 MapReduce 处在同一层面。
(2) Spark 可以部署在YARN 上
(3) Spark 原生支持对HDFS文件系统的访问

```text
问题的产生 ===> 解决方案 ===> 工程实现 ====> 方案优化
   |              |            |              |
   |              |            |              |
   V              V            V              V
 网页搜索     Google论文      Hadoop         Spark
```

#### 1.2 与Spark的第一次亲密接触
##### 1.2.1 环境准备
##### 1.2.2 下载安装Spark
##### 1.2.3 Spark 下的WordCount

Spark 的 word count
```scala
val rawFile = sc.textFile("README.md")
val words = rawFile.flatMap(line => line.split(" "))
val wordNumber = word.map(w => (w,1));
val wordCount = wordNumber.reduceByKey(_ + _);
wordCounts.foreach(println)
```
其实你会发现，这里的scala 很像 python 里的dataframe

## 第二部分 Spark 核心概念

### 第2章 Spark 整体框架
#### 2.1 编程模型
#### 2.1.1 RDD
RDD 就是一个分布式的无序的列表
如果将前面提到的MapReduce 模型，换一种方式来展现的话，就是对输入的数据经过一系列的操作后输出另一组数据。

![](/images/rdd.png)

#### 2.2 运行框架
#### 2.3 源码阅读环境准备

### 第3章 SparkContext 初始化
#### 3.1 spark-shell
首次使用spark.
spark-shell --> spark-submit --> spark-calss --> repl.Main --> SparkSubmit.main --> SparkILoop --> createSparkContext

#### 3.2 SparkContext 的初始化综述

SparkContext 是进行Spark 应用开发的主要接口，是Spark 上层应用与底层实现的中转站

SparkContext 在初始化过程中，主要涉及以下内容
• SparkEnv
• DAGScheduler
• TaskScheduler
• SchedulerBackend
• WebUI

SparkContext 的构造函数中最重要的入参是SparkConf

#### 3.3 Spark Repl 综述

Scala 原生的Repl 是使用Obejct 来封装输入的代码。那么有什么不妥呢？ 那是因为在序列化和反序列化过程中，对象的构造函数会被再次调用，产生副作用。


### 第4章 Spark 作业提交
4.1 作业提交
4.2 作业执行

### 第5章 部署方式分析

## 第三部分 Spark Lib
### 第6章 Spark Streaming
Spark Steam 能够对流数据 以近乎实时的速度处理。比storm 相比有更高的的吞吐能力

### 6.1 Spark Streaming 的整体架构
• 数据一直处在变化中。
• 数据无法回退
• 数据一直源源不断地涌进
#### 6.1.1 DSteam 
用一句话 概括Spark Stream 地处理思路，那就是 **将连续地数据持久化，离散化，然后进行批量处理**

• 数据持久化：将网络上接受到地数据先暂时存储下来，为后续的处理出错时事件重演提供可能
• 离散化：数据源源不断输入，将其按时间分片。 采用1分钟为时间间隔，将连续一分钟内得到的数据作为一个处理单元。
• 分片处理 将持久化下来的数据分批进行处理，处理机制用RDD。

DStream(Discretized Stream) 表示从数据源获取持续性的数据流以及经过转换后的数据流。DStream 由持续的RDD序列组成。

![](http://images2015.cnblogs.com/blog/592648/201605/592648-20160520122801701-1805419023.jpg)

Spark Streaming 主要由三个模块构成
• Master 主要记录DStream 之间的依赖关系，并负责任务调度以生成新的RDD
• Worker节点： 从网路接收数据，存储并执行RDD的计算
• Client: Clint负责向Spark Streaming 中灌入数据

#### 编程接口

### 第7章 SQL
https://www.jianshu.com/p/23f445aeff1f
在Spark 1.0 中又一个新增的功能，即对SQL 的支持，也就是说可以用SQL 来对数据进行查询。对于任何一个SQL 子系统都需要有parser, optimizizer, execution 三大功能。

|工具                   |来源              |
|-----------------------|:------------------|
|Flume, Sribw, Chukwa   |日志收集和系统分析系统把来自Apche/Nginx 的日志收集到HDFS上，然后通过Hive 查询|
|Sqoop|把用户和业务纬度数据（一般存储在oracle/MySQL中) 定期倒入Hive, 那么OLTP数据就有一个用于OLAP的副本了|
|ETL| 通过ETL 工具从其他外部DW数据源里导入的数据|

OLTP（On-line Transaction Processing) Insert Update Delete`
OLAP (On-line Analytical Processing)  read
#### 7.1 SQL 语句的通用执行过程分析
       
```text 
        Projection                 FILTER
           ^                          ^
           |                          |
SELECT  f1,f2,f3 FROM tableX WHERE condition
   |                     |
   V                     V
INDICATOR             Data Source
```

最终发现 SQL 表达式中的顺序与常见的RDD 处理逻辑在表达顺序上有差异：

```text
Data Source ---> Operation ---> Result

Result --- Data Source --- Operation
```

SQL 语句在分析执行过程中会经历四个步骤
语法解析，操作绑定，优化执行策略，交付执行

Query  --> Parse --> Bind --> Optimize --> Execute

语法解析之后，会形成一个语法树。树中的每个节点是执行的规则（rule），整个树被称为执行策略。

![](https://upload-images.jianshu.io/upload_images/2472711-2f793016da93391e.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

### 第8章 GraphX
#### 8.2 分布式图计算处理技术介绍
#### 8.2.1 属性图
按照图中节点的复杂程度可以分：简单节点图模型，复杂节点图模型
按照一条边可以连接的顶点数据：简单图模型，超图模型
##### 8.2.2 图数据的存储与分割
图具有多种存储结构，常见的包括Adjacency Matrix, Adjacency List, Orthogonal List

为了并行计算，就要有效分割，就要有效实现解耦，将一个大图分割为若干个子图，主要两个原则:
(1) 提高子图内部的连通性，降低子图之间的连通性，这尤其适合分布式的并行处理机制。
(2) 考虑子图规模的均衡性，尽量保证各子图的数据规模均衡，不要出现较大的偏斜，从数据规模方面防止各并行任务的执行时间相差过大，降低任务同步控制的影响。

### 第9章 MLLib

#### 第四部分 附录
