---
title: Java并发编程实战
date: 2017-10-28 21:35:40
categories: Java
tags:
---


第1章 简介


第一部分 基础知识

第2章 线程安全性
线程执行顺序不同,则最后的结果不同.

race condition 并不会总是产生错误, 还需要某种不可预测的时序.

常见的竞态条件类型: Check-Then-Act

example:
@NotThreadSafe
public class LazyInitRace {
     private ExpensiveObject instance = null;

     public ExpensiveObeject getInstance () {
          if (instance == null) {
               instance = new ExpensiveObject();
          }
          return instance;
     }
}

这是单例模式在单线程下的写法,多线程时, 线程A 和 线程B 同时执行 getInstance, A 判断为空, 创建一个新的实例, B 是否创建新的实例就是不确定的, 因此此单例模式在多线程环境下并不成立.

统计servlet 数量,
在servlet 请求里写的 count++ , 拆开是 "读-改-写" 操作

可以使用 java.util.concurrent.atomic 包中的一些原子变量类

private final AtomicLong count = new AtomicLong(0);

count.increamentAndGet();

2.3 加锁机制

内置锁(Intrinsic Lock or Monitor Lock)
Synchronized (lock) {
     //获取对象的锁
}

可以在servlet 方法前加synchronized 关键字,但是性能会下降,解决的方法就是不锁住整个方法,而是锁住最小的一块代码

内置锁是可重入的, 操作粒度是"线程"而不是 "调用". (pthread 是 以调用为粒度的)
public class Widget {
     public synchronized void doSomething() {

     }
}

public class LoggingWidget extends Widget {
     public synchronized void doSomething () {
             System.out.println("call dosomething");
               super.doSomething();
     }
}

如果不是可重入的,就会出现死锁

第3章 对象的共享
多线程编程除了临界区(Critical Section) 加锁

内存可见性 (Memory Visibility)

不仅要防止多个线程同时修改状态, 而且要确保当一个线程修改状态后,其他线程能够看到发生的变化. 同步

public  class NoVisibility  {
     private static boolean ready;
     private static int number;

     private static class ReaderThread extends Thread {
          public void run() {
               while (!ready)
                    Thread.yield();
               System.out.println(number);
          }
     }

     public static void main(String[] args) {
          new ReaderThread().start();
          number = 42;
          ready = true;
     }
}

while 循环可能无限循环,

重排序, ReaderThread 可能先读 ready , 再读 number, 输出0

可见性,一致性.
没有同步的话,两个同步块之间的变量不能保证可见

Volatitle 变量
一种稍弱的同步机制. 变量共享,确保更新操作通知其他线程, 该变量的操作不会与其他内存操作一样重排序. 非阻塞

从内存角度看, 写入 volatitle 变量 相当退出同步块, 读取 volatitle 相当于 进入同步块

所以可以将上述的ready 设为 volatitle

当仅当满足下面所有条件时, 才应该使用volatile 变量

对变量的写入操作不依赖变量的当前值, 或者确保只有单个线程更新变量值
该变量不会与其他状态变量一起纳入不变性条件中
在访问变量时不需加锁

3.2 发布与逸出
http://blog.csdn.net/a19881029/article/details/8165188
发布: publish

逸出: Escapse

发布：使对象能够在当前作用域之外的代码中使用

逸出：当某个不该被发布的对象被发布时，这种情况称为逸出

3.3 线程封闭

3.3.1
ad-hoc  线程封闭
维护线程封闭性的职责完全由程序实现来承担

3.3.2
栈封闭
写局部变量

3.3.3
ThreadLocal 类
概括起来说，对于多线程资源共享的问题，同步机制采用了“以时间换空间”的方式，而ThreadLocal采用了“以空间换时间”的方式.

3.4 不变性

3.4.1 Final 域

3.4.2 使用Volatile 类型来发布不可变对象

使用 Volatile 和 final 关键字 发布 不可变对象, 因为不可变,所以可以安全发布

3.5


第4章 对象的组合

第5章 构建基础模块

第二部分 结构化并发应用程序
第6章 任务执行

第7章 取消与关闭

第8章 线程池的使用

第9章 图形用户界面应用程序

第三部分 活跃性，性能，与测试

第10章 避免活跃性危险

第11章 性能与可伸缩性

第12章 并发程序的测试

第13章 显示锁

第14章 构建自定义同步工具

第15章 原子变量与非阻塞同步机制

第16章 Java内存模型
