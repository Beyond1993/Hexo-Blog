---
title: CMU-15640-2
date: 2017-08-20 08:03:01
categories: CMU课程
tags: cmu
---
# Project 1 Transparent-Remote-File-Operations
实现 cat filename 的远程调用，file 不在本机上.

## Configure
Ubuntu 16.04 

Makefile:
之前很奇怪 Makefile 为什么可以直接 all: client server,原来是相同目录下可以已经有了 client.c server.c  同名文件。
```basemake
PROGS=client server
CFLAGS+=-Wall
#add inlcude path
CFLAGS+=-I/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/include/
all: $(PROGS)

clean:
        rm -f *.o $(PROGS)
```
add the absolute path of libdirtree.so to LD_LIBRARY_PATH

http://www.cnblogs.com/benio/archive/2010/10/25/1860394.html
大写 -L 指定第三方库的目录
小写 -l 指定库文件，但要注意文件名，只是个链接，并不是真正的文件
大写 -I 指定头文件目录

这个也不行
gcc -Wall -I/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/include/ -L/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/lib/ -ldirtree   server.c   -o server

真是活见鬼了，在AWS上一次性编译成功，而且都没有设置 LD_LIBRARY_PATH. 看来本机的环境复杂，以后所有的实验都要放在instacne上跑了.

## 原理
![](/images/rpc.png)

[参考](http://www.cnblogs.com/codingexperience/p/5930752.html)

## Run


## Analysis

## 小结
rpc的本质就是序列化与反序列化
