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

In traditional Unix systems, each process consists of one thread. In modern systems, multithreaded program consist of more than one thread.

But in Linux a thread is just a light weight process.

A program itself is not a process, a process is an active program and related resources.

In Linux, we use fork() system, which creates a new process by duplicating an existing one.

In contemporary Linux kernels, fork() is actually implemented via the clone() system call, then exe() call, then exit() call.

A parent process can inquire about the status of a terminated child via the wait4()1system call, which enables a process to wait for the termination of a specific process. When a process exits, it is placed into a special zombie state that represents terminated processes until the parent calls wait() or waitpid().

The waitpid() is enhance version of wait() function with more control. From parent view, I want to check the status if children, from children view, exist() just placed into a zombie state until parent call wait() or waitpid()

The Linux kernel internally refers to processed as tasks. This is the reason for task scheduler, The kernel stores the list of processed in a circular doubly linked list called task list.

Each element is a process descriptor of the type struct task_struct, which is similar to Classs and Oject.

The process descriptor contains the data that describes the executing program—open files, the process’s address space, pending signals, the process’s state, and much more.

PID is an int, actually short int, the maximum value is 32768, the problem is why we use an int(index) to define the id in task list, which is doubly linked list?

How to get the current task?

How to set the priority for processes?

All processes are descendants of the init process.


## 第4章 进程调度

cooperative multitasking : Linux, Unix, Max OS9, Windows3.1 协作式任务管理器
preemptive multitasking: 抢占式 任务管理器

Linux 设计来一个 O(1) 的 Scheduler

CFS use a red-black tree to manager the list of runnable process.

O(1) scheduler: Rotating Staircase Deadline scheduler, Completely Fair Scheduler (CFS)

I/0-Bound Versus Processor-Bound Processes

I/0 not only the disk, but also any type of blockable resource, such as keyboard input , mouse, or network I/0. Most GUI are I/0 bound, they spend most of their time waiting on user ineraction.

Process Priority
two separate priority ranges:
first:
nice value : -20 ~ +19, default is 0, nice value is smaller, priority is higher. To see a list if nice value ps -el

second:
real-time priority The values are configurable, but by default range from 0 to 99, inclusive. Opposite from nice values, higher real-time priority values correspond to a greater priority

The core of CFS's scheduling algorithm: Pick the task with the smallest vruntime.
CFS uses a red-black tree to manage the list of runnable processes and efficiently find the process with the smallest vruntime.
key for each node is the runnable process’s virtual runtime.


The vruntime variable stores the virtual runtime of a process, which is the actual runtime (the amount of time spent running) normalized (or weighted) by the number of runnable processes.

How to calculate the vruntime?

## 第5章 系统调用

## 第6章 内核数据结构

## 第7章 中断和中断处理

## 第8章 下半步和推后执行的工作


## 第9章 内核同步介绍
Locks are implemented using atomic operations that ensure no race exists.
In linux, there are different locks

10 Kernel Synchronization Methods

Atomic Operations are the foundation on which other sychronization methods are built.

kernel provides two sets of interfaces for atomic operations: integers, individual bits

other architecture, lock the memory bus.

atomic_t ensures the compiler does not (erroneously but cleverly) optimize access to the value—it is important the atomic operations receive the correct memory address and not an alias

1987年，SUN和TI公司合作开发了RISC微处理器——SPARC。

https://blog.csdn.net/jeffasd/article/details/51321743


### 9.1 临界区和竞争条件
### 9.2 加锁
锁是采用原子操作实现的，原子操作不存在竞争

## 第10章 内核同步方法
### 10.1 原子操作
原子操作是其他同步方法的基石．
内核提供了两组原子操作接口：　针对整数，针对单独的位．
大多数体系结构提供支持原子操作的简单算术指令，而有些体系结构缺少简单的原子操作指令，但是也为单步执行提供了锁内存总线的指令．
### 10.1.1　原子整数操作
原子操作通常是内联函数，往往是通过内嵌汇编指令来实现的．如果某个函数本来就是原子的，那么它往往会被定义成一个宏．在大部分体系结构上，读取一个字本身就是一种原子操作．

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


Character Device: is accessed as a stream of data keyboard
Block Device: is accessed randomly . Such as hard disk, more difficulty to manage

THE SMALLEST ADDRESSABLE UNIT ON A BLOCK DEVICE IS A SECTOR.

Most block devices have 512-byte sectors. But other size like 2-kilobyte is common

Software has different goals and therefore imposes its own smallest logically addressable unit, which is the block. Therefore, block sizes are a power-of-two multiple of the sector size and are not greater than the page size.

Common block sizes are 512 bytes, 1 kilobyte, and 4 kilobytes.

Sector, Block, Buffer, Segment, request queue, double linkedlist. Linus Elevator,

I/O scheduler VS processor scheduler.

I/O schedulers perform two primary actions to minimize seeks: merging and sorting.

Merge : Sort

Linus Elevator will cause starvation.

front merging is rare compared to back merging ??? Don't understand
## 第15章 进程地址空间

## 第16章 页高速缓存和页回写

## 第17章 设备于模块

## 第18章 调试

## 第19章 可移植性

## 第20章 补丁，开发和社区

