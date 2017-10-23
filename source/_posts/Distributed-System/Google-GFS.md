---
title: Google-GFS
date: 2017-10-05 21:37:12
categories: Distributed-System
tags:
---
Google File System

大名顶顶的google 三架马车之一。



写文件：
```text
                      +-------------+    
4. All is cached      | Application |-----1. Where is (chunk, 2ef0)-------------------------->+------------+
+---------------------+-------------+                                                         | GFS master |
|   +---------------->| GFS client  |<---2.The primary is CS3, the replicas are CS0 and CS5---+------------+
|   |                 +-------------+                                                         
|   |                      ^      |
|   |                      |      |  3.1 Cache(2ef0)
|   |  3.6(2ef0) is cached |      | 
|   |                      |      V
|   |                 +---------------------+
|   |7. Done          |    Chunkserver 0    |<----------------------+
|   |                 | Secondary replica A |-----------+           |
|   |                 +---------------------+           |           |
|   |                      ^      |                     |           |
|   |                      |      |  3.2 Cache(2ef0)    |6. Done    |5. Write (2ef0)
|   |  3.5(2ef0) is cached |      |                     |           |
|   |                      |      V                     |           |
|   |                 +---------------------+<----------+           |
|   +-----------------|    Chunkserver 3    |-----------------------+
+-------------------->|  Primary  replica A |-----------------------+
                      +---------------------+<----------+           |
                           ^      |                     |           |
                           |      |  3.3 Cache(2ef0)    |           |
       3.4(2ef0) is cached |      |                     |6. Done    |5. Write(2ef0)
                           |      V                     |           |
                      +---------------------+           |           |
                      |    Chunkserver 5    |-----------+           |
                      | Secondary replica A |<----------------------+
                      +---------------------+  

```

先是串联缓存。
如果写失败，让client重新发写请求。
而不是引用恢复机制，恢复机制可能带来更多问题.
