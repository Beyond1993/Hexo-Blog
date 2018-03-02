---
title: Interview-Pure-Storage
date: 2017-10-24 01:05:33
categories: Interview
tags:
---



还有老题Event/Fire多线程。详细题目解释可以参考：https://www.evernote.com/shard/s ... 906d67ab4ea189304f1
大意就是一个timeline上，event里面有两个method， 一个是register一个是fire，然后不停有Callback cb进来，register就一直把cb存起来，但是当call了fire这个method，先把之前所有register的event全部执行一遍，而且从此以后register不在存cb，而是直接运行当前传进来的cb
先来单线程
```java
class CallBack {
        String name;
        
        public CallBack() {
        }
        
        public CallBack(String name) {
                this.name = name;
        }
        
        public void call() {
                System.out.println("CallBack Event " + this.name + "is running now");
        }
}
```
不用担心callback class，他给了这个class，我只是为了自己测试。看下面就好了
```java
public class EventFire {
        Queue<CallBack> eventQueue = new LinkedList<>();
        boolean isFired = false;
        
        public void reg_cb(CallBack cb) {
                if (!isFired) {. From 1point 3acres bbs
                        eventQueue.offer(cb);
                }
                else {
                        cb.call();
                }
        }
        
        public void fire() {
                while (!eventQueue.isEmpty()) {
                        eventQueue.poll().call();
                }
                        
                isFired = true;
        }

}
```
然后继续，实现thread safe，先问了把isFired = true放在前面有什么好处。然后就是第二个版本
```java
public class EventFire {
        Queue<CallBack> eventQueue = new LinkedList<>();
        boolean isFired = false;
        Lock lock;
        
        public void reg_cb(CallBack cb) {
                lock.lock();
                if (!isFired) {
                        eventQueue.offer(cb);
                        lock.unlock();
                }
                else {
                        lock.unlock();
                        cb.call();
                }
        }
        public void fire() {
                lock.lock();
                isFired = true;
                while (!eventQueue.isEmpty()) {
                        CallBack cb = eventQueue.poll();
                        lock.unlock();
                        cb.call();
                        lock.lock();
                }
                lock.unlock();
        }
}
```
然后walk through了一遍code和所有的锁，问了每一种情况（真的是每一种，加和不加有什么区别，有什么风险，千万不要紧张，一紧张就直接晕了）
然后ok，开始把锅扔给intership, 说现在有一个intership想优化code，写了第三个版本：
```java
public class EventFire {
        Queue<CallBack> eventQueue = new LinkedList<>();
        boolean isFired = false;
        Lock lock;
        
        public void reg_cb(CallBack cb) {
                lock.lock();
                if (!isFired) {
                        eventQueue.offer(cb);
                        lock.unlock();
                }
                else {
                        lock.unlock();
                        cb.call();
                }
        }
        public void fire() {
                lock.lock();
                isFired = true;
                lock.unlock();
                while (!eventQueue.isEmpty()) {
                        CallBack cb = eventQueue.poll();
                        cb.call();
                }
        }
}
```
有什么区别，有没有风险，然后walk through了一遍，然后这个intership还改, 第四个版本：
```java
public class EventFire {
        Queue<CallBack> eventQueue = new LinkedList<>();
        boolean isFired = false;
        Lock lock;
        
        public void reg_cb(CallBack cb) {
                lock.lock();
                if (!isFired) {
                        eventQueue.offer(cb);
                        lock.unlock();
                }
                else {
                        lock.unlock();
                        cb.call();
                }
        }
        
        public void fire() {
                lock.lock();
                lock.unlock();
                isFired = true;
                while (!eventQueue.isEmpty()) {
                        CallBack cb = eventQueue.poll();
                        cb.call();
                }. from: 1point3acres.com/bbs 
        }
}
```
问有没有风险，当然有风险，锁和没锁一样的。然后继续改，第五个版本：
```java
public class EventFire {
        Queue<CallBack> eventQueue = new LinkedList<>();
        boolean isFired = false;
        Lock lock;
        
        public void reg_cb(CallBack cb) {
                lock.lock();
                if (!isFired) {
                        eventQueue.offer(cb);
                        lock.unlock();
                }
                else {
                        lock.unlock();
                        cb.call();
                }
        }
        
        public void fire() {
                isFired = true;
                lock.lock();
                lock.unlock();
                while (!eventQueue.isEmpty()) {
                        CallBack cb = eventQueue.poll();
                        cb.call();
                }
        } 
}
```
问有没有风险，这个版本没有风险，这是一个barrier,可以在改完了isFired之后去尝试aquire lock，没拿到的话就会进入wait，所以这种改法是对的。这里开始没答好，我紧张了满脑子就记得lock是lock整个instance，然后完全没考虑如果没有去aquire lock，其实thread是不会wait的。比如如果fire method里面没有lock的话，他是可以在register被lock了的情况下还能执行的. 
然后聊了聊如果要求keep order有什么想法，用两个queue，然后交换queue的时候lock，他说you are on a good track
然后聊了聊不加锁实现thread safe，主要思路就是在register，在判断了isFired之后进去的时候判断queue为不为空，可以知道其他thread有没有call fired，并且有没有执行完。
然后就问有没有什么问题，就闲聊了一会，然后说时间超了，就说88了


