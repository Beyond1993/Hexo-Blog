---
title: Consistent Hash
date: 2019-03-02 19:54:16
categories: Distributed-System
tags:
---

缓存失效

```java
import java.util.Collection;  
import java.util.SortedMap;  
import java.util.TreeMap;  
 
public class ConsistentHash<T> {  
 
 private final HashFunction hashFunction;  
 private final int numberOfReplicas;  
 private final SortedMap<Integer, T> circle = new TreeMap<Integer, T>();  
 
 public ConsistentHash(HashFunction hashFunction, int numberOfReplicas,  
     Collection<T> nodes) {  
   this.hashFunction = hashFunction;  
   this.numberOfReplicas = numberOfReplicas;  
 
   for (T node : nodes) {  
     add(node);  
   }  
 }  
 
 public void add(T node) {  
   for (int i = 0; i < numberOfReplicas; i++) {  
     circle.put(hashFunction.hash(node.toString() + i), node);  
   }  
 }  
 
 public void remove(T node) {  
   for (int i = 0; i < numberOfReplicas; i++) {  
     circle.remove(hashFunction.hash(node.toString() + i));  
   }  
 }  
 
 public T get(Object key) {  
   if (circle.isEmpty()) {  
     return null;  
   }  
   int hash = hashFunction.hash(key);  
   if (!circle.containsKey(hash)) {  
     SortedMap<Integer, T> tailMap = circle.tailMap(hash);  
     hash = tailMap.isEmpty() ? circle.firstKey() : tailMap.firstKey();  
   }  
   return circle.get(hash);  
 }  
 
} 
```


一台机器 设置 1000 个 virtaul machine. 


当这一台机器挂掉，所有请求 转移到 下一个点，但是下一个虚拟机并不一定在一台机器上。

[Consistent Hash](https://juejin.im/post/5b8f93576fb9a05d11175b8d)
