---
title: Linux Kernel Development
date: 2018-05-13 14:12:17
categories: Linux
tags:
---

## 第1章 Linux 内核简介

## 第2章 从内核出发

## 第3章 进程管理

在Unix 中， each thread includes a unique program counter, process stack, set of processor registers.

a process is an active program and related resources.

和 Unix 不同的是， 在linux中， 并没有线程和进程之分， 线程是一种特殊进程。

psef:

UID PID PPID NLWP PGID SID


UID
PID
PPID parent process id
NLWP number of light weight process

## 第4章 进程调度

cooperative multitasking : Linux, Unix, Max OS9, Windows3.1 协作式任务管理器
preemptive multitasking: 抢占式 任务管理器

Linux 设计来一个 O(1) 的 Scheduler

CFS use a red-black tree to manager the list of runnable process.

## 第5章 系统调用

## 第6章 内核数据结构

## 第7章 中断和中断处理

## 第8章 下半步和推后执行的工作

## 第9章 内核同步介绍

## 第10章 内核同步方法

## 第11章 定时器和时间管理

## 第12章 内存管理

## 第13章 虚拟文件系统

虚拟文件系统 virtual file system (VFS) 作为内核子系统，为用户空间提供了文件和文件系统相关的接口.

VFS 使得 用户可以直接适用 open(), read(), write() 这样的系统调用无须考虑具体文件系统和实际物理介质。 

标准的系统调用从一个文件系统拷贝到另一个文件系统。老式 DOS 是无力完成上述工作的。这就是为什么双系统 ubuntu 可以访问 windows 文件，而 windows 不能访问 ubuntu.



## 第14章 块 I/O 层

流设备(字符设备) ： 顺序读取，如： 键盘 

块设备: 随机读取 如：硬盘

因为字符设备仅仅需要控制当前位置，而块设备访问的位置必须能够在介质的不同区间前后移动。

所以内核里并没有 专门的 子系统管理字符设备，但是对块设备的管理却有一个专门的子系统.

而且块设备对执行性能的要求很高, 优化硬盘操作对整个系统性能可以带来大幅度提升

缓存区是为了实现 I/O 的 异步操作，大大提升性能
## 第15章 进程地址空间

## 第16章 页高速缓存和页回写

## 第17章 设备于模块

## 第18章 调试

## 第19章 可移植性

## 第20章 补丁，开发和社区

