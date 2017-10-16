---
title: Java-Concurrency-Race-Condition
date: 2017-09-01 22:26:39
categories: Java
tags:
---

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
