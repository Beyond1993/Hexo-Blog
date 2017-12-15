---
title: CMU-18645-Learn-OpenMP
date: 2017-12-13 22:52:02
categories: CMU
tags:
---

OpenMP 简易教程

```cpp
int main(int argc, char* argv[]) {
  clock_t t1 = clock(); 
  #pragma omp parallel for
  for ( int j = 0; j < 2; j++ ) { 
    test();
  }
  clock_t t2 = clock();
  printf("Total time = %d\n", t2-t1);
  test(); 
  return 0;
}
```

OpenMP 并行程序设计
1. fork/join 并行执行模式的概念
fork / join 模式是共享存储式并行程序的并行模式

基本思想是，程序开始只有一个主线程，程序中的串行部分都由主线程执行，并行的部分是通过派生其他线程来执行，但是如果并行部分没有结束时是不会执行串行部分的。

2. OpenMP 指令和库函数介绍

OpenMP 指令使用格式：
 **# pragma omp 指令[子句[子句]...]**

常用指令:
  parallel, 用在一个代码段之前，表示这段代码将被多个线程并行执行。
  for, 用于 for 循环之前，将循环分配到多个线程中并行执行，必须保证每次循环之间无相关性。
  parallel for, parallel 和 for 语句结合，也是用在一个for 循环前，表示for 循环的代码将被多个线程并行执行。
  sections, 用在可能会被并行执行的代码之前
  parallel sections, parallel和 sections 两个语句的结合
  critical, 用在一段代码临界区之前
  single, 用在一段只被单个线程执行的代码段之前，表示后面的代码段将被单线程执行。
  
  flush，
   barrier，用亍并行区内代码的线程同步，所有线程执行到 barrier 时要停止，直到所有线程都执行到 barrier 时才 继续往下执行。
   atomic，用亍指定一块内存区域被制劢更新
   master，用亍指定一段代码块由主线程执行
   ordered， 用亍指定并行区域的循环按顺序执行
   threadprivate, 用亍指定一个变量是线程私有的。

OpenMP 除上述指令外，还有一些库函数，下面列出几个常用的库函数:
omp_get_num_procs, 返回运行本线程的多处理机的处理器个数。 
omp_get_num_threads, 返回当前并行区域中的活劢线程个数。 
omp_get_thread_num, 返回线程号
omp_set_num_threads, 设置并行执行代码时的线程个数
omp_init_lock, 刜始化一个简单锁
omp_set_lock， 上锁操作
omp_unset_lock， 解锁操作，要和 omp_set_lock 函数配对使用。 
omp_destroy_lock， omp_init_lock 函数的配对操作函数，关闭一个锁
OpenMP 的子句有以下一些
private, 指定每个线程都有它自己的变量私有副本。 
firstprivate，指定每个线程都有它自己的变量私有副本，并且变量要被继承主线程中的初值。 
lastprivate，主要是用来指定将线程中的私有变量的值在并行处理结束后复制回主线程中的对应变量。 
reduce，用来指定一个戒多个变量是私有的，并且在并行处理结束后这些变量要执行指定的运算。 
nowait，忽略指定中暗吨的等待
num_threads，指定线程的个数
schedule，指定如何调度 for 循环迭代
shared，指定一个戒多个变量为多个线程间的共享变量
ordered，用来指定 for 循环的执行要按顺序执行
copyprivate，用亍 single 指令中的指定变量为多个线程的共享变量
copyin，用来指定一个 threadprivate 的变量的值要用主线程的值迚行刜始化。 
default，用来指定并行处理区域内的变量的使用方式，缺省是 shared 

3. parallel 指令的用法

4. for 指令的用法

5. sections 和 section 指令的用法
section 语句将代码块分成几个不同阶段，每段都并行执行。

```java
void main(int argc, char *argv)
{
#pragma omp parallel sections { #pragma omp section
printf(“section 1 ThreadId = %d\n”, omp_get_thread_num()); #pragma omp section
printf(“section 2 ThreadId = %d\n”, omp_get_thread_num()); #pragma omp section
printf(“section 3 ThreadId = %d\n”, omp_get_thread_num()); #pragma omp section
printf(“section 4 ThreadId = %d\n”, omp_get_thread_num()); }
```

使用section 语句时，需要注意这个方式需要保证各个section 里的代码执行时间相差不大.

sections 之间是顺序执行的。

** for 语句分摊是由系统自动进行，每次循环没有时间上差距，使用section 就是手动划分，最终并行的好坏得依赖于程序员 **

C++ 的 OpenMP 就类似于java5 之后的 concurrency 的包，封装里常见的多线程方法。




OpenMP 中数据处理子句

1. private 子句
将一个或多个变量设成线程私有变量，但是这个私有变量不能继承原有共享变量的值

2. firstprivate 子句

firstprivate 解决了，私有变量不能继承原来共享变量值的问题

3. lastprivate 子句
lastprivate 子句，讲道理的话，应该是继承多线程中的私有变量给共享变量赋值，但是问题来了，因为线程结束的顺序是不确定的。所以它是规定是语法上的最后一个。


由亍在并行区域内是多个线程并行执行的，最后到底是将那个线程的最终计算结果赋给了对应的共享变量呢? OpenMP 规范中指出，如果是循环迭代，那么是将最后一次循环迭代中的值赋给对应的共享变量;如果是 section 构造，那么是最后一个 section 语句中的值赋给对应的共享变量。注意这里说的最后一个 section 是指程序语法上 的最后一个，而丌是实际运行时的最后一个运行完的。

如果是类(class)类型的变量使用在 lastprivate 参数中，那么使用时有些限制，需要一个可访问的，明确的 缺省构造函数，除非变量也被使用作为 firstprivate 子句的参数;还需要一个拷贝赋值操作符，并且这个拷贝赋值 操作符对亍丌同对象的操作顺序是未指定的，依赖亍编译器的定义。





4. threadprivate 子句
threadprivate 子句用来指定**全局**的对象被各个线程各自复制了一个私有的拷贝，即各个线程具有各自私有的 全局对象。

threadprivate 的对应叧能用亍 copyin，copyprivate，schedule，num_threads 和 if 子句中，丌能用亍任 何其他子句中

5. shared 子句
shared 子句用来声明一个戒多个变量是共享变量。
用法如下:
shared(list) 需要注意的是，在并行区域内使用共享变量时，如果存在写操作，必须对共享变量加以保护，否则丌要轻易使
用共享变量，尽量将共享变量的访问转化为私有变量的访问。 循环迭代变量在循环构造区域里是私有的。声明在循环构造区域内的自劢变量都是私有的。

6. default 子句

7. reduction 子句

```cpp
int i, sum = 100;
#pragma omp parallel for reduction(+: sum) for ( i = 0; i < 1000; i++ )
{
sum += i; }
printf( "sum = %ld\n", sum);
```

8. copyin 子句

9. copyprivate 子句

OpenMP 中的任务调度
1. Schedule 子句用法

2. 静态调度(static)

3. 动态调度(dynamic)

4. guided 调度(guided)

5. runtime 调度 
