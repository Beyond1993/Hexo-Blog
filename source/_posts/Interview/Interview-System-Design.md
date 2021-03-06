---
title: Interview-System-Design
date: 2017-09-22 00:42:50
categories: Interview
tags:
---

Snake 原则

Scenario: case/interface
Necessary: constrain/hypotheis
Application: service/algorithm
Kilobit: data 数据流，数据存储
Evolve: 评估

系统设计的面试。其实主要是针对大规模，分布式系统的设计。

1. Tiny URL 
Tiny URL 是系统设计中的hello word. 
Scenario:
插入短链接，
查找长链接

Necessary:
月活跃用户，日活跃用户.

Daily active users
*1,000,000

Insert 
Per day: 1,000,000 * 1% (function usage) * 10(function frequency) = 1000,000
Per Year: 100,000 * 365 = 36,500,000
Per second: 100,000/86400 = 1.2
Lookup:
Per day: 1,000,000 * 100 % (function usage) * 3 (function frequency) = 3,000,000
Per second: 3,000,000/86400 = 35

一般请求数超过100 ／ 一秒， 就需要考虑分布式架构
但是35只是一个平均值，可能白天到达七八十， 高峰期过一百，就需要分布式了

做个总结：
     日活用户是基础 ，
     插入查找算清楚。
     字母编码省空间，
     随机算法防冲突 。


2. Web Crawler 

3. Google Suggestion
http://dbaplus.cn/news-21-483-1.html
只对一个query 的前四个字符 inverted index

4. Location Based Service
系统学习LBS相关系统设计的核心要点：
地理位置信息存储与查询常用算法之 Geohash
如何设计 Yelp
如何设计 Uber
如何设计 Facebook Nearby

5. Message System & Rate Limiter
聊天系统中的 Pull vs Push
讲解一种特殊的Service - Realtime Service
用户在线状态的获取与查询 Online Status
访问限制系统及其设计原理 Rate Limiter

6. 设计一个Uber

7. 设计一个twitter

(1) 要求设计一个DNS的Cache结构，要求能够满足每秒5000以上的查询，满足IP数据的快速插入，查询的速度要快。（题目还给出了一系列的数据，比如：站点数总共为5000万，IP地址有1000万，等等）

(2) 有N台机器，M个文件，文件可以以任意方式存放到任意机器上，文件可任意分割成若干块。假设这N台机器的宕机率小于1/3，想在宕机时可以从其他未宕机的机器中完整导出这M个文件，求最好的存放与分割策略。

(3) 假设有三十台服务器，每个上面都存有上百亿条数据（有可能重复），如何找出这三十台机器中，根据某关键字，重复出现次数最多的前100条？要求用Hadoop来做。

(4) 设计一个系统，要求写速度尽可能高，说明设计原理。

(5) 设计一个高并发系统，说明架构和关键技术要点。

(6) 有25T的log(query->queryinfo)，log在不段的增长，设计一个方案，给出一个query能快速反回queryinfo

以上所有问题中凡是不涉及高并发的，基本可以采用google的三个技术解决，分别为：GFS，MapReduce，Bigtable，这三个技术被称为“google三驾马车”，google只公开了论文而未开源代码，开源界对此非常有兴趣，仿照这三篇论文实现了一系列软件，如：Hadoop、HBase、HDFS、Cassandra等。

在google这些技术还未出现之前，企业界在设计大规模分布式系统时，采用的架构往往是database+sharding+cache，现在很多公司（比如taobao，weibo.com）仍采用这种架构。在这种架构中，仍有很多问题值得去探讨。如采用什么数据库，是SQL界的MySQL还是NoSQL界的Redis/TFS，两者有何优劣？ 采用什么方式sharding（数据分片），是水平分片还是垂直分片？据网上资料显示，weibo.com和taobao图片存储中曾采用的架构是Redis/MySQL/TFS+sharding+cache，该架构解释如下：前端cache是为了提高响应速度，后端数据库则用于数据永久存储，防止数据丢失，而sharding是为了在多台机器间分摊负载。最前端由大块大块的cache组成，要保证至少99%（该数据在weibo.com架构中的是自己猜的，而taobao图片存储模块是真实的）的访问数据落在cache中，这样可以保证用户访问速度，减少后端数据库的压力，此外，为了保证前端cache中数据与后端数据库中数据一致，需要有一个中间件异步更新（为啥异步？理由简单：同步代价太高。异步有缺定，如何弥补？）数据，这个有些人可能比较清楚，新浪有个开源软件叫memcachedb（整合了Berkeley DB和Memcached），正是完成此功能。另外，为了分摊负载压力和海量数据，会将用户微博信息经过片后存放到不同节点上（称为“sharding”）。

这种架构优点非常明显：简单，在数据量和用户量较小的时候完全可以胜任。但缺定早晚一天暴露出来，即：扩展性和容错性太差，维护成本非常高，尤其是数据量和用户量暴增之后，系统不能通过简单的增加机器解决该问题。

于是乎，新的架构便出现了。主要还是google的那一套东西，下面分别说一下：

GFS是一个可扩展的分布式文件系统，用于大型的、分布式的、对大量数据进行访问的应用。它运行于廉价的普通硬件上，提供容错功能。现在开源界有HDFS(Hadoop Distributed File System)，该文件系统虽然弥补了数据库+sharding的很多缺点，但自身仍存在一些问题，比如：由于采用master/slave架构，因而存在单点故障问题；元数据信息全部存放在master端的内存中，因而不适合存储小文件，或者说如果存储的大量小文件，那么存储的总数据量不会太大。

MapReduce是针对分布式并行计算的一套编程模型。他最大的优点是：编程接口简单，自动备份（数据默认情况下会自动备三份），自动容错和隐藏跨机器间的通信。在Hadoop中，MapReduce作为分布计算框架，而HDFS作为底层的分布式存储系统，但MapReduce不是与HDFS耦合在一起的，你完全可以使用自己的分布式文件系统替换掉HDFS。当前MapReduce有很多开源实现，如Java实现Hadoop MapReduce，C++实现Sector/sphere等，甚至有些数据库厂商将MapReduce集成到数据库中了。

BigTable俗称“大表”，是用来存储结构化数据的，个人觉得，BigTable在开源界最火爆，其开源实现最多，包括：HBase，Cassandra，levelDB等，使用也非常广泛。

除了google的这三家马车，还有其他一些技术：

Dynamo：亚马逊的key-value模式的存储平台，可用性和扩展性都很好，采用DHT（Distributed Hash Table）对数据分片，解决单点故障问题，在Cassandra中，也借鉴了该技术，在BT和电驴的中，也采用了类似算法。

虚拟节点技术：该技术常用于分布式数据分片中。具体应用场景是：有一大坨数据（maybe TB级或者PB级），我们需按照某个字段（key）分片存储到几十（或者更多）台机器上，同时想尽量负载均衡且容易扩展。传统的做法是：Hash(key) mod N，这种方法最大缺点是不容易扩展，即：增加或者减少机器均会导致数据全部重分布，代价忒大。于是乎，新技术诞生了，其中一种是上面提到的DHT，现在已经被很多大型系统采用，还有一种是对“Hash(key) mod N”的改进：假设我们要将数据分不到20台机器上，传统做法是hash(key) mod 20，而改进后，N取值要远大于20，比如是20000000，然后我们采用额外一张表记录每个节点存储的key的模值，比如：

node1：0~1000000

node2：1000001~2000000

。。。。。。

这样，当添加一个新的节点时，只需将每个节点上部分数据移动给新节点，同时修改一下这个表即可。

Thrift：Thrift是一个跨语言的RPC框架，分别解释一下“RPC”和“跨语言”，RPC是远程过程调用，其使用方式与调用一个普通函数一样，但执行体发生在远程机器上。跨语言是指不同语言之间进行通信，比如c/s架构中，server端采用C++编写，client端采用PHP编写，怎样让两者之间通信，thrift是一种很好的方式。

文章最前面的几道题均可以映射到以上几个系统中的某个模块中，如：

（1） 关于高并发系统设计。主要有以下几个关键技术点：缓存，索引，数据分片，锁粒度尽可能小。

（2） 问题2涉及到现在通用的分布式文件系统的副本存放策略。一般是将大文件切分成小的block（如64MB）后，以block为单位存放三份到不同的节点上，这三份数据的位置需根据网络拓扑结构配置，一般而言，如果不考虑跨数据中心，可以这样存放：两个副本存放在同一个机架的不同节点上，而另外一个副本存放在另一个机架上，这样从效率和可靠性上，都是最优的（这个google公布的文档中有专门的证明，有兴趣的可参阅一下。）。如果考虑跨数据中心，可将两份存在一个数据中心的不同机架上，另一份放到另一个数据中心。

（3）问题4涉及到BigTable的模型。主要思想是将随机写转化为顺序写，进而大大提高写速度。具体是：由于磁盘物理结构的独特设计，其并发的随机写（主要是因为磁盘寻道时间长）非常慢，考虑到这一点，在BigTable模型中，首先会将并发写的大批数据放到一个内存表（称为“memtable”）中，当该表大到一定程度后，会顺序写到一个磁盘表（称为“SSTable”）中，这种写是顺序写，效率极高。说到这，可能有读者问，随机读可不可以这样优化？答案是：看情况。通常而言，如果读并发度不高，则不可以这么做，因为如果将多个读重新排列组合后再执行，系统的响应时间太慢，用户可能接受不了，而如果读并发度极高，也许可以采用类似机制。



参考：http://dongxicheng.org/search-engine/system-designing-in-finging-jobs/

https://soulmachine.gitbooks.io/system-design/content/cn/task-scheduler.html?q=
