---
title: Multi Threads
date: 2019-12-02 02:34:41
categories: TODO
tags:
---


class Solution {
}


1. Dead lock

A. 
B.

A deadlock is a situation in which two computer programs sharing the same resource are effectively preventing each other from accessing the resource, 
resulting in both programs ceasing to function. The earliest computer operating systems ran only one program at a time.
ex: 
A wait for B
B wait for A

https://segmentfault.com/a/1190000016351095

public class TestThread {
   public static Object Lock1 = new Object();
   public static Object Lock2 = new Object();
   
   public static void main(String args[]) {
      ThreadDemo1 T1 = new ThreadDemo1();
      ThreadDemo2 T2 = new ThreadDemo2();
      T1.start();
      T2.start();
   }
   
   private static class ThreadDemo1 extends Thread {
      public void run() {
         synchronized (Lock1) {
            System.out.println("Thread 1: Holding lock 1...");
            
            try { Thread.sleep(10); }
            catch (InterruptedException e) {}
            System.out.println("Thread 1: Waiting for lock 2...");
            
            synchronized (Lock2) {
               System.out.println("Thread 1: Holding lock 1 & 2...");
            }
         }
      }
   }
   private static class ThreadDemo2 extends Thread {
      public void run() {
         synchronized (Lock2) {
            System.out.println("Thread 2: Holding lock 2...");
            
            try { Thread.sleep(10); }
            catch (InterruptedException e) {}
            System.out.println("Thread 2: Waiting for lock 1...");
            
            synchronized (Lock1) {
               System.out.println("Thread 2: Holding lock 1 & 2...");
            }
         }
      }
   } 
}

// output
Thread 1: Holding lock 1...
Thread 2: Holding lock 2...
Thread 1: Waiting for lock 2...
Thread 2: Waiting for lock 1...

  
// fixed deadlock version
public class TestThread {
   public static Object Lock1 = new Object();
   public static Object Lock2 = new Object();
   
   public static void main(String args[]) {
      ThreadDemo1 T1 = new ThreadDemo1();
      ThreadDemo2 T2 = new ThreadDemo2();
      T1.start();
      T2.start();
   }
   
   private static class ThreadDemo1 extends Thread {
      public void run() {
         synchronized (Lock1) {
            System.out.println("Thread 1: Holding lock 1...");
            
            try {
               Thread.sleep(10);
            } catch (InterruptedException e) {}
            System.out.println("Thread 1: Waiting for lock 2...");
            
            synchronized (Lock2) {
               System.out.println("Thread 1: Holding lock 1 & 2...");
            }
         }
      }
   }
   private static class ThreadDemo2 extends Thread {
      public void run() {
         synchronized (Lock1) {
            System.out.println("Thread 2: Holding lock 1...");
           
            try {
               Thread.sleep(10);
            } catch (InterruptedException e) {}
            System.out.println("Thread 2: Waiting for lock 2...");
            
            synchronized (Lock2) {
               System.out.println("Thread 2: Holding lock 1 & 2...");
            }
         }
      }
   } 
}

//output:
Thread 1: Holding lock 1...
Thread 1: Waiting for lock 2...
Thread 1: Holding lock 1 & 2...
Thread 2: Holding lock 1...
Thread 2: Waiting for lock 2...
Thread 2: Holding lock 1 & 2...
  
2. Race condition

3. ReadWriteLock

Read and Read no lock
Read need check write lock
Write doesn't check Read lock
Wrtite and Write need lock

4. CAS 操作

https://en.wikipedia.org/wiki/Compare-and-swap

2.线程1准备用CAS将变量的值由A替换为B，在此之前，线程2将变量的值由A替换为C，又由C替换为A，然后线程1执行CAS时发现变量的值仍然为A，所以CAS成功。但实际上这时的现场已经和最初不同了，尽管CAS成功，但可能存在潜藏的问题。
比如：现有一个用单向链表实现的堆栈，栈顶为A，这时线程T1已经知道A.next为B，然后希望用CAS将栈顶替换为B：head.compareAndSet(A,B);在T1执行上面这条指令之前，
线程T2介入，将A、B出栈，再pushD、C、A。而对象B此时处于游离状态：此时轮到线程T1执行CAS操作，检测发现栈顶仍为A，所以CAS成功，栈顶变为B，但实际上B.next为null，其中堆栈中只有B一个元素，
C和D组成的链表不再存在于堆栈中，平白无故就把C、D丢掉了。以上就是由于ABA问题带来的隐患，各种乐观锁的实现中通常都会用版本戳version来对记录或对象标记，避免并发操作带来的问题，
在Java中，AtomicStampedReference<E>也实现了这个作用，它通过包装[E,Integer]的元组来对对象标记版本戳stamp，
从而避免ABA问题，例如下面的代码分别用AtomicInteger和AtomicStampedReference来对初始值为100的原子整型变量进行更新，AtomicInteger会成功执行CAS操作，
而加上版本戳的AtomicStampedReference对于ABA问题会执行CAS失败

5.  Optimistic and Pessimistic Locking

5. mutex

6. Semaphore

7. disruptor




            

public class SequenceGeneratorUsingSynchronizedBlock extends SequenceGenerator {
     
    private Object mutex = new Object();
 
    @Override
    public int getNextSequence() {
        synchronized (mutex) {
            return super.getNextSequence();
        }
    }
 
}

2. 
  
  
/* how to modify below
 * scenario
 * 1. read intensive
 * 2. write intensive
 * 3. interval demand(sometimes read heavy, sometimes read heavy)
 */
public class ReadWriteLock{

  private int readers       = 0;
  private int writers       = 0;
  private int writeRequests = 0;

  public synchronized void lockRead() throws InterruptedException{
    while(writers > 0 || writeRequests > 0){ // reader starvation if writers has large population comparing to readers
      wait(); //??
    }
    readers++;
  }

  private synchronized void unlockRead(){
    readers--;
    notifyAll(); //for write
  }

  public synchronized void lockWrite() throws InterruptedException{
    writeRequests++;

    while(readers > 0 || writers > 0){  // writer starvation if readers has large population comparing to writers
      wait();
    }
    writeRequests--;
    writers++;
  }

  private synchronized void unlockWrite() throws InterruptedException{
    writers--;
    notifyAll();
  }
}

lockWrite
lockWrite
lockRead
unlockRead

readers  writers writeRequests
0        0        0
0        1        1=>0            lockWrite
0        1        0=>1            lockWrite
0        
(reader thread wait)
  
  
  
  
  init:
key : user
value: date of message that was sent before


global data:
list of users to be sent today


process read through list of users to send text
when the value of the key is the time of yesterday or does not existed(get value from all nodes) => lock is available
process tries to acquire the lock for all the nodes:
1. generate unique string which only current process knows
2. store current time in ms
3. trying to acquire the lock for all the machines one by one
        a. set the key to the unique string with a timer, if the lock cant be aquired within timeout period(timeout = 5% * timer), move on to the next node
4. if aquired most of the node(> n / 2) && current time - time in step 2 - time estimated for text sending < timer => locking successful
5. set the key to the time sent(without timer), remove user from the list, start sending operations
  
  
if the value of the key is inconsistent, meaning consists time of yesterday, time of today, do read repair
 * update to time of today in sync operation

 
if process down before sending text, key will be deleted when timer ran out, then other process will pick up the key and send the text

  

