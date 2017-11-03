---
title: Weekly-Diary-16.md
date: 2017-11-01 17:54:10
categories: 周记
tags:
---

今天遇到查询thrift 里的enum
变量名后面.value 直接返回Integer


2. 巧用index, 在数据存储中， 有很多pin, 很多对应的links, 但是pins 对应的 links 有很多重复， 所以只存一份links array, 在pins 里记录下index, 节省空间

3. p2p 

pin----------p2p--------&lt;pin----------&lt;navboost query
source                      target                    |
^                           p2pscore                  |
|                                                     |                            
|                                                     |
+-----------------------------------------bm25--------+

query > list&gt;pins&lts; 
