---
title: Java Concurrent Package
date: 2017-12-29 04:39:55
categories: Java
tags:
---

![整体架构图](http://hi.csdn.net/attachment/201111/10/0_13209086922UBB.gif)

![](https://www.uml-diagrams.org/examples/java-7-concurrent-executors-uml-class-diagram-example.png)

![](https://www.uml-diagrams.org/examples/java-7-concurrent-collections-uml-class-diagram-example.png)

![](https://www.uml-diagrams.org/examples/java-7-concurrent-future-uml-class-diagram-example.png)

Executor: 执行对象

* Executor: 执行已提交的Runnable任务的对象

    --* ExecutorService

        ---ThreadPoolExecutor  动态的线程池

        ---AbstractExecutorService

        ----* ScheduleExecutorService  任务调度

           ---- ScheduledThreadPoolExecutor

  ---  Executors  工厂方法，构建4种线程池

---* CompletionService 生产新的异步任务与使用已完成任务的结果分离开来的服务

        ----ExecutorCompletionService

---* Future 表示异步计算的结果

    ---* FutureTask

    ---* RunnableFuture

        ---RunnableScheduledFuture

---* Callable 返回结果并可能抛出异常的任务

---* RejectedExecutionHandler 无法由ThreadPoolExecutor执行的任务处理程序

---Queue: 任务队列

---ConcurrentLinkQueue  基于链接节点的无界线程安全队列

---* BlockingQueue 阻塞队列

    ---ArrayBlockingQueue

    ---DelayQueue

    ---LinkedBlockingQueue

    ---PriorityBlocingQueue

    ---SynchronousQueue

    ---BlockingDeque  阻塞双端队列

        ---LinkedBlockingDeque

---Concurrent Collection: 并发集合

* ConcurrentMap

    ---ConcurrentHashMap

    ---* ConcurrentNavigableMap

        ---ConcurrentSkipListMap

---ConcurrentSkipListSet 基于ConcurrentSkipListMap的可缩放并发NavigableSet

---CopyOnWriteArrayList ArrayList的一个线程安全的变体

---CopyOnWriteArraySet

---atomic: 原子

---AtomicInteger

---基本变量的原子操作

---lock: 锁

---* Lock

    ---ReentrantLock

---* ReadWriteLock

    ---ReenTrantReadWriteLock

---* Condition

---Timer: 计时器

---TimeUnit

---Synchronizer: 同步

---Semaphore 计数信号量

---CountDownLatch 同步辅助类，计数器

---CyclicBarrier 同步辅助类，使一组线程相互等待

---Exchanger 可以再对中队元素进行配对和交换的线程的同步点

