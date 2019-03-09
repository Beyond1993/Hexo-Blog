---
title: CMU 15619 3.3 Social Networking Timeline with Heterogeneous Backends
date: 2018-01-05 01:45:39
categories: CMU
tags:
---


分别用 MySQL, MongoDB, HBase 作为后台搭建Social Network。

Learning Objectives:

1. Experiment with the provisioning, configuration and management of a Database­as­a­ Service (DBaaS) offering.
2. Compare and contrast the ETL processes and query operations of RDS MySQL, MongoDB and HBase using a Java API.
3. Combine multiple heterogeneous back­end database services to provide multi­modal data to a single, complex web application.
4. Compare and contrast the relative capabilities of different database systems when used in a single application.


没有哪一项技术是完美的，不完美的人生就需要大家组团帮忙。

|Dataset Name | Data Store Used | Description | Location |
|:------------|:----------------|:------------|:---------|
| Login Information | MySQL (RDS) | [UserID, Password] | ~/users.csv |
| User Profile | MySQL (RDS) | [UserID, Name, Profile Image URL] | ~/userinfo.csv |
| Relation | HBase | [Followee, Follower] | ~/link.csv |
| Posts | MongoDB | JSON Format|  ~/post.json (On MongoDB Instance) |
|Profile and Post Images| S3 | Your backend system only need to provide URLs | URLs are in userinfo.csv and posts.json|

