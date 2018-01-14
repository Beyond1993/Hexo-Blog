---
title: Java 并发编程 极客学院
date: 2017-12-29 04:10:16
categories: Java
tags:
---

## 前言

## 第1章 并发行与多线程介绍

## 第2章 多线程的实现方法

## 第3章 线程中断

## 第4章 线程挂起，恢复与终止

## 第5章 守护线程与线程阻塞

## 第6章 Volatile 关键字（上）

## 第7章 Volatile 关键字（下）

## 第8章 synchronized 关键字

## 第9章 synchronized 的另一个重要作用： 内存可见性

## 第10章 实现内存可见性的两种方法比较： synchronized 和 volatile

## 第11章 多线程环境下安全使用集合API

## 第12章 死锁

## 第13章 可重入内置锁

## 第14章 线程协作: wait, notify, notifyAll

## 第15章 notify 通知的遗漏

## 第16章 notifyAll 造成的早期通知问题

## 第17章 生产者-消费者模型

## 第18章 深入Java内存模型(1)

## 第19章 深入Java内存模型(2)

## 第20章 并发新特性-Executor 框架与线程池
Executor 框架 包括,Thread Pool, Executor, Executors, ExecutorService, CompletionService, Future, Callable.

Runnable 接口里面, 又一个 run 方法，返回值是 void
首先Callable 接口，里面只有一个call 方法, 返回一个范型

Feature 接口提供了， 三种任务: 1. 判断任务是否完成, 2. 能够中断任务 3. 能够获取任务执行结果

```java
public class Test {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newCachedThreadPool();
        Task task = new Task();
        Future<Integer> result = executor.submit(task);
        executor.shutdown();
         
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }
         
        System.out.println("主线程在执行任务");
         
        try {
            System.out.println("task运行结果"+result.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
         
        System.out.println("所有任务执行完毕");
    }
}
class Task implements Callable<Integer>{
    @Override
    public Integer call() throws Exception {
        System.out.println("子线程在进行计算");
        Thread.sleep(3000);
        int sum = 0;
        for(int i=0;i<100;i++)
            sum += i;
        return sum;
    }
}
```




## 第21章 并发新特性-Lock 锁与条件变量

## 第22章 并发新特性-阻塞队列与阻塞栈

## 第23章 并发新特性-障碍器CyclicBarrier
希望创建一组任务，它们并发的执行工作，另外的一个任务在这一组任务并发执行结束前，一直阻塞等待，直到该组任务全部执行结束，这个任务才得以执行。

```java
import java.util.concurrent.BrokenBarrierException; 
import java.util.concurrent.CyclicBarrier;
public class CyclicBarrierTest {
  public static void main(String[] args) {
    //创建CyclicBarrier对象， //并设置执行完一组5个线程的并发任务后，再执行MainTask任务 
    CyclicBarrier cb = new CyclicBarrier(5, new MainTask()); 
    new SubTask("A", cb).start();
    new SubTask("B", cb).start();
    new SubTask("C", cb).start();
    new SubTask("D", cb).start();
    new SubTask("E", cb).start();
  } 
}
/**
* 最后执行的任务
*/
class MainTask implements Runnable {
  public void run() { 
    System.out.println("......终于要执行最后的任务了......");
  } 
}
/**
* 一组并发任务
*/
class SubTask extends Thread {
  
  private String name; 
  private CyclicBarrier cb;
  
  SubTask(String name, CyclicBarrier cb) { 
    this.name = name;
    this.cb = cb;
  }
  
  public void run() {
    System.out.println("[并发任务" + name + "] 开始执行");
    for (int i = 0; i < 999999; i++) ; //模拟耗时的任务 
    System.out.println("[并发任务" + name + "] 开始执行完毕，通知障碍器"); 
    try {
      //每执行完一项任务就通知障碍器
      cb.await();
    } catch (InterruptedException e) {
      e.printStackTrace();
    } catch (BrokenBarrierException e) {
      e.printStackTrace(); }
    } 
}
```

## 第24章 并发新特性-信号量Semaphore
