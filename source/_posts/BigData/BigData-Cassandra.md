---
title: BigData-Cassandra
date: 2017-11-22 01:44:33
categories: BigData
tags:
---

partitions 的方法: 1 range hbase 2. list 3. hash

为什么要consistent hash. 比如说两台服务器 模2, 三台服务器 模3， rehash 很麻烦，想找个一个哈希和服务器数量无关。一般是2^n, 2^128

将master 的路由表分担到没个server 上, hash 值也不是直接对应一个server 而是，再通过一张表 

增加节点和删除节点的数据迁移大大减少，只和一个点通信. 任何节点加入，直接从后继节点获得信息，任何节点去除，就把信息还给后继节点
理论上只会影响一个节点. 

MD5 --> Murmur3 Hash Murmur3 hash 是非加密的hash, 比MD5 快五倍

peer 2 peer Gossip Protocol 八卦协议. 一传十十传百, 可能有互相写来写去的问题。不能保证全局的强一致性。

Membership
Failure Detection

fan number
time to live (TTL)

解决load balance
virtual nodes: 一个server 虚拟化出不同的node， 相互交错，虚拟化带来的问题： maintain 跟多信息
move nodes: 转发给其他节点

Replication
N node
Avoid all replications on the same rack

Consistency
Cassandra is a Ap system according to the CAP theorem
Tunable consistency
N is the number of replicas
W is the consistency level of write operations 写操作所需的成功数
R is the consistency level of read operations 读所需的成功数

Strong consistency
W + R > N
Dynamo : vector clock
Cassandra: timestamp 但是要求系统误差小于1毫秒

Eventrauly Consistency:
Read Repairi: 一定概率触发同步机制

凡是该失败的不失败，重试，就可能雪崩

Merkie Tree
git 里， 比较是否一致. 如果是写频繁的，就要不停的构建树

如何增加写的速度: 只append, 造成一个数据多个append， 所以要compaction
增加读的速度:compaction, cache , blomm filter
compaction: STCS LCS DTCS



Cassandra 3.x High Availability

Chapter 1: Cassandra's Approach to High Availability

Chapter 2: Data Distribution

Chapter 3: Replication

Chapter 4: Data Centers

Chapter 5: Scaling Out

Chapter 6: High Availability Features in the Native Java Client

Chapter 7: Modeling for Availability

Chapter 8: Anti-Patterns

Chapter 9: Failing Gracefully
