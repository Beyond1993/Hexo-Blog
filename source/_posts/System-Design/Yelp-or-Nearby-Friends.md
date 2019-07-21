---
title: Yelp or Nearby Friends
date: 2019-07-20 20:04:09
categories: System Design
tags:
---

## 设计饿了吗

搜索附近的餐馆， 电影院，

## service 功能

Service 会存储不同地方的信息给用户提供搜索服务。用户咨询过后，会有返回一系列附近的地点。

至少需要满足基本三个条件:
1. 用户可以 增加/删除/更新 地点信息
2. 可以通过用户的经纬度 找到 一定半径之内的地点。
3. 用户可以给地点增加 反馈和评价, 包括 图片， 文本 星级

额外功能:

1. 用户需要实时的低延时的搜索体验
2. 查询操作远大于 添加和更新操作

## 数据量估算
全球500M(五亿)地点, 100K(十万) QPS, 每年地点数量和QPS 以 20% 增长。

## 数据库 Schema

Place 数据库表

1. LoacationID (8 bytes)
2. Name (256 bytes)
3. Latitude (8 bytes)
4. Longitude (8 bytes)
5. Description (512 bytes)
6. Category (1 byte): E.g. 咖啡店 餐馆 电影院.

Review 数据库表

1. LocationID (8 bytes)
2. ReviewID (4 bytes)
3. ReviewText (512 bytes)
4. Rating (1 bytes)

## 系统 APIs


 
