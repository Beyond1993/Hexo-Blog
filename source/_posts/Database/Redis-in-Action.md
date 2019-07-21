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

### 8.5 Streaming API
我们将使用 Redis 的 PUBLISH 命令 和 SUBSCRIBE 命令来实现流服务器的其中一部分功能: 当用户发布一条消息时，程序会将这条消息通过 PUBLISH 发送给某个频道， 而各个过滤器则通过 SUBSCRIBE 来订阅并接收那个频道的消息，并在发现与过滤器相匹配的消息时，将消息回传(yield back) 给 web 服务器，然后由服务器将这些消息发送给客户端.

## 9 Reducing memory use

## 10 Scaling Redis



## 11 Scripting Redis with Lua

the c***k will insert an empty value into redis for the requested key. but how to get the actual value from db.
