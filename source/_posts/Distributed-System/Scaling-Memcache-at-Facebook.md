---
title: Scaling Memcache at Facebook
date: 2019-03-02 18:40:32
categories: Distributed-System
tags:
---

## 1. Introduction

## 2. Overview

## 3. In a Cluster: Latency and Load

### 3.1 Reducing Latency

### 3.2 Reducing Load

#### 3.2.1 Leases


通过租约令牌，memcached 可以验证和判断是否这个数据应该被存储，由此仲裁并发写操作。 （但问题是，如何仲裁并发写操作？）

what is "Arbirate current write" ?

#### 3.2.2 Memcache Pools

#### 3.2.3 Replication Within Pools

## 3.3 Handing Failures

## 4. In a Region: Replication

### 4.2 Regional Pools

### 4.3 Cold Cluster Warmup

## 5 Across Regions: Consistency

## 6 Single Server Improvements

### 6.1 Performance Optimization

### 6.2 Adaptive Slab Allocator

### 6.3 The Transient Item Cache

### 6.4 Software Upgrades

## 7 Memcahce Workload

### 7.1 Measurements at the Web Server

### 7.2 Pool Statistics

### 7.3 Invalidation Latency
 
