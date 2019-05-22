---
title: Redis in Action
date: 2019-05-17 14:23:05
categories: Database
tags:
---

## 1 Getting to know Redis

Redis is an **in-memory** **remote** database that offers high performance, replication, and a unique data model to produce a platform for solving problem.


out-of-process cache. the client process and serve process are similar as Client and Service, request and response.

the in memory cache such as BBCache should be faster than. 


three concept:

in-of-process cache == share memory cache?

A shared memory cache is an in-process cache. All in-process caches need not necessarily reside in shared memory.

out-of-process cache




## 2 Anatomy of a Redis web application

## 3 Commands in Redis

### 3.6 Publish/subscribe

The Publish and Subscribe Model (push messaging)

We don't use pub / sub very much because two reasons

one: in olde version if redis, a client that had subscribed to channels but didn't read sent messages fast enougth, 消息积压. will kill redis, or make operate system crash.




## 4 Keeping data safe and ensuring performance

## 5 Using Redis for application support

## 6 Application component in Redis

### 6.5.1 Single-recipient publich/subscribe replacement

## 7 Search-based application

## 8 Building a simple social networks

## 9 Reducing memory use

## 10 Scaling Redis

## 11 Scripting Redis with Lua

the c***k will insert an empty value into redis for the requested key. but how to get the actual value from db.
