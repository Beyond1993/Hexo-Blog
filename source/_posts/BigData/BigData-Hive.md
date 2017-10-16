---
title: BigData-Hive
date: 2017-10-16 06:34:28
categories: BigData
tags:
---

Hive First day



Data repository.



Traditional relationship database like MySQL is transaction oriented, it is online and faster.  reduce the redundancy.

The data repository is Theme oriented.  It is used for data analysis,  so the redundancy and latency might be high. 



derby is an open source database built on java, the core of derby.jar is only 2M, 

it can be used as single database or application embedded library



OLTP (online transaction processing)  for database

OLAP (online analytical processing )for data repository



Three definitional characteristics of data repository:

Theme Orient

Time Related

None Modify



Three functional characteristics of data repository:

Data acquisition

Data Storage

Data Access



Metadata

Hive store the meta data in the meta store, such as MySQL, Derby(default).



Two kinds of Metadata:

Technology Metadata is created by developer

Commerical Metadata is described from the commercial view.



Hive

Hive is a data repository tool based on Hadoop.



Database table name  ----> HDFS folder or file

Database table field    ----> HDFS colum of file



components:

HCatalog:

WebHcat: RestFul API



Architecture:





https://drive.google.com/open?id=0B43ctlqRX23kX2JNaGd1VXN0UFU





Three user interface:

CLI, Client (Beeline), WebUI



start-methods:

command: /hive/bin/hive or hive -service cli

hive web: hive -service hwi

remote port 10000 : nohup hive -service hiveserver &



Data in Hive



Four types of the data model:

Table: managed table.

External Table: a link to external data.

Partition: sub folder, according to one key decided by User.

Bucket: sub folder, according to the hash value of the specific field. 





reference:

http://www.tianshouzhi.com/api/tutorials/hive

https://cwiki.apache.org/confluence/display/Hive


﻿Hive Data Definition Language



Creating Hive Tables

hive> create table pokes (foo INT, bar STRING);



Creating table with Partition

hive> create table invites (foo INT, bar STRING) partitioned by (ds STRING);

The partition column is a virtual column. It is not part of the data itself.



Browing through tables

hive> show tables;

hive>show table '*s';  --table that end with 's'

hive>DESCRIBE invites.



Altering and Dropping Tables

  hive> ALTER TABLE events RENAME TO 3koobecaf;
  hive> ALTER TABLE pokes ADD COLUMNS (new_col INT);
  hive> ALTER TABLE invites ADD COLUMNS (new_col2 INT COMMENT 'a comment');
  hive> ALTER TABLE invites REPLACE COLUMNS (foo INT, bar STRING, baz INT COMMENT 'baz replaces new_col2')


metadata stored in the own server with the location, version, date.

the location link to s3, 

in s3, the file stored as sequence file.

SEQUENCEFILE是Hadoop API 提供的一种二进制文件，它将数据以<key,value>的形式序列化到文件中。这种二进制文件内部使用Hadoop 的标准的Writable 接口实现序列化和反序列化。它与Hadoop API中的MapFile 是互相兼容的。Hive 中的SequenceFile 继承自Hadoop API 的SequenceFile，不过它的key为空，使用value 存放实际的值， 这样是为了避免MR 在运行map 阶段的排序过程。

 


