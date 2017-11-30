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

 

Hive Data Manipulation Language.



Load Data

hive> LOAD DATA LOCAL INPATH './examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;
  hive> LOAD DATA LOCAL INPATH './examples/files/kv2.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2008-08-15');
  hive> LOAD DATA LOCAL INPATH './examples/files/kv3.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2008-08-08');
  hive> LOAD DATA INPATH '/user/myname/kv2.txt' OVERWRITE INTO TABLE invites PARTITION (ds='2008-08-15');

Create tables:

CREATE TABLE IF NOT EXISTS wfeng_test( age int, name String,
salary String, title String) COMMENT 'Wayne test';


Insert:

INSERT INTO wfeng_test (age, name, salary, title)  
VALUES (24, 'Wayne', 55, 'software engineer');


Drop table

DROP TABLE wfeng_test


Describe table 

DESC wfeng_test


Load Data From AWS S3:



CREATE EXTERNAL TABLE wfeng_test_queries (STRING wfeng_query)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
LOCATION 's3://pinlogs/users/wfeng/Result.csv' ;



CREATE TABLE IF NOT EXISTS wfeng_test_queries (query String)
COMMENT ‘wayne test’
ROW FORMAT DELIMITED
LINES TERMINATED BY ‘\n’
STORED AS TEXTFILE;


Select and Filters



SELECT * FROM wfeng_test
 

这句话一般是不执行map reduce 的。因为是全表扫描。



Group by



Join



Multi table Insert



Stream

hive> FROM invites a INSERT OVERWRITE TABLE events SELECT TRANSFORM(a.foo, a.bar) AS (oof, rab) USING '/bin/cat' WHERE a.ds > '2008-08-09';



use explain to show the execution plan



﻿Use load or sqoop import

select 



SELECT [ALL | DISTINCT] select_expr, select_expr,...

FROM table_references

[WHERE where_condition]

[GROUP BY col_list]

[CLUSTER BY col_list 

    | [DISTRIBUTE BY col_list] [SORT BY col_list]

    | [ORDER BY col_list]

[LIMIT number]



SORT BY 

Ordering : It orders data at each of ‘N’ reducers, but each reducer can have overlapping ranges of data. 

Outcome : N or more sorted files with overlapping ranges.  



ORDER BY: 

Ordering : Total Ordered data. 

Outcome : Single output i.e. fully ordered.



DISTRIBUTE BY, define the partitioner when many Reducer.



CLUSTER BY: short-cut for both Distribute By and Sort By.



------------

Not all query will convert to map reduce



eg, select * from ... just scan the whole table.



NULL problem.

If there is a variable is NULL, the expression becomes NULL



function : nvl(p1,p2), transform p1 to p2 if p1 is NULL.

eg, nvl(salary, 0);



select * from emp where comm=null; wrong

select * from emp where comm is null; right



 select distinct name, age, job  from emp;



组合一致才是真的重复。

-----------------------------------

Fetch Task  for simple query:

configuration

- set hive.fetch.task.conversion = more

- hive --hiveconf hive.fetch.task.conversion = more

- modify hive-site.xml file



Filter

put the string to ''. 



Fuzzy query: 

% --> any string

_  --> any single char



select empno,ename,sal from emp where ename like '%\\_%';



the first \ is an escape character, the second \ is a backslash.



how to sort with NULL.

increase order, NULL is on the top

decrease order, NULL is on the bottom.



but I want to put NULL on the bottom with increased order.

transform NULL to 0.



Function:

inner function

define function



math function

character function

collect function: size select size(map(1,'Tom', 2, "Mary')); ==> 2

cast function:

date function:

condition function: coalesce, case...when

aggregation function: count, sum

table generation function: explode, select explode(map(1, 'Tom', 2,'Mary', 3, 'Mike'));



Hive join table

Four types join operation:

equal join

not equal join

external join

self join



sub query only support from and where

in

not in



reference:

http://saurzcode.in/2015/01/hive-sort-vs-order-vs-distribute-vs-cluster/



Hive 必需从HDFS中导入表。



需要注意的是，s3 上的文件名是无所谓的。一个目录就代表了一个表。会从指定的目录中读表。目录的名字和表名也不需要保持一致。



DROP TABLE wfeng.google_query_Ads_domain;



CREATE EXTERNAL TABLE wfeng.google_query_Ads_domain(query STRING, domain STRING)

ROW FORMAT DELIMITED 

FIELDS TERMINATED BY ',' 

LINES TERMINATED BY '\n'

STORED AS TEXTFILE

LOCATION 's3://pinlogs/users/wfeng/ads_search_domain/';



s3://pinlogs/users/wfeng/ads_search_domain/any_filename.csv


http://www.cnblogs.com/smartloli/p/4356660.html


Equal:

select daily_pin_search_volume, query from wfeng.query_daily_volume where query = 'card';



not equal:

where a.domain not like '%no_domain%'  group by a.domain;


select feedview from pinalytics.clean_feedview_log_v2 where dt = '2017-08-01'  limit 50;

Caused by: org.apache.hadoop.hive.ql.metadata.HiveException: Hive Runtime Error while processing writable (null)
	at org.apache.hadoop.hive.ql.exec.MapOperator.process(MapOperator.java:543)
	at org.apache.hadoop.hive.ql.exec.mr.ExecMapper.map(ExecMapper.java:163)
	... 8 more
Caused by: java.lang.RuntimeException: Parquet record is malformed: empty fields are illegal, the field should be ommited completely instead


我的是因为feedview 层数太多了，不能直接select 再，写入到表中。



hive map = 99%, reduce = 33%



Reasons:

data skew, one partition is too big. hot key

one instance machine performance is bad. (可能性很低 )


https://www.youtube.com/watch?v=CV-M8CBEyM0&t=1132s



PTF

in Place Table Function?

Table in --> Table out



is the content after 'over' input?



Input is partitioned (optionally ordered)

An instance of a PTF operates on a Partition

Partitioning drives parallel execution



Similar to MR, predate to MapReduce



why?

Aggerations by Partition -> Rank, top N

Inter row Calculation -> Time series analysis

Multi Pass Algorithm

Graph Algorithm --> implement recursive.



Example: Market  Basket Analysis? 



functions:

LAG: 对每一行记录的向上的第N个记录。 没有就设为DEAFULT， LAG(col, n, DEFAULT)

LEAD: 对每一行记录取向下的第N个记录。



First_value

Last_value



要指定order by



window clause:



https://stackoverflow.com/questions/30861919/what-is-rows-unbounded-preceding-used-for-in-teradata





select query,  keyword from 

(select query,keyword, ROW_NUMBER() over (partition by query order by impression_sum DESC) as impression from 

(select query, keyword, sum(impression) as impression_sum

  from ad.ad_search_query_onsite_agg  

  where  query = 'quotes' or query = 'car' 

  and dt <= '2017-08-02' and dt >= '2017-07-03' group by query, keyword)

)

where impression <= 10



select query,  keyword from 

(select query, keyword, ROW_NUMBER() OVER (PARTITION BY query order by sum(impression)) as impression

  from ad.ad_search_query_onsite_agg  

  where  query = 'quotes' or query = 'car' 

  and dt <= '2017-08-02' and dt >= '2017-07-03' group by query, keyword

)

where impression <= 10




cookie1,2015-04-10 10:00:02,url2

cookie1,2015-04-10 10:00:00,url1

cookie1,2015-04-10 10:03:04,url3

cookie1,2015-04-10 10:50:05,url6

cookie1,2015-04-10 11:00:00,url7

cookie1,2015-04-10 10:10:00,url4

cookie1,2015-04-10 10:50:01,url5

cookie2,2015-04-10 10:00:02,url22

cookie2,2015-04-10 10:00:00,url11

cookie2,2015-04-10 10:03:04,url33

cookie2,2015-04-10 10:50:05,url66

cookie2,2015-04-10 11:00:00,url77

cookie2,2015-04-10 10:10:00,url44

cookie2,2015-04-10 10:50:01,url55







---window_function directoery is important, file name is not 

Drop TABLE wfeng.learn_window_function;

CREATE TABLE wfeng.learn_window_function (

    cookieid string,

    createtime string,  

    url STRING       

) 

ROW FORMAT DELIMITED 

FIELDS TERMINATED BY ',' 

LINES TERMINATED BY '\n'

STORED AS TEXTFILE

LOCATION 's3://pinlogs/users/wfeng/learn_window_function/';



select * from wfeng.learn_window_function;



SELECT cookieid, createtime, url, 

       ROW_NUMBER() OVER(PARTITION BY cookieid ORDER BY createtime) AS rn,

       LAG(createtime,1,'1970-01-01 00:00:00') OVER(PARTITION BY cookieid ORDER BY createtime) AS last_1_time

       --LAG(createtime,2) OVER(PARTITION BY cookieid ORDER BY createtime) AS last_2_time

       FROM wfeng.learn_window_function;

       

----window 

SELECT cookieid, createtime, url, 

       --ROW_NUMBER() OVER(PARTITION BY cookieid ORDER BY createtime ROWS between unbounded preceding and current row) AS rn,

       count(url) OVER(PARTITION BY cookieid ORDER BY createtime ROWS between unbounded preceding and current row) AS rn

       --LAG(createtime,1,'1970-01-01 00:00:00') OVER(PARTITION BY cookieid ORDER BY createtime) AS last_1_time

       FROM wfeng.learn_window_function;



select * from ad.ad_search_query_onsite_agg where dt <= and="" dt="">= '2017-07-03'





1查看 data skew, 看每个hadoop map counter 的 number of bytes written and  number of bytes read

2 某一个map一直run不出来，就找一个成功的map来对比

不怕数据规模大，就怕数据死Q（skew ).



 第一步避免死Q的原则，尽量减少数据的规模，想尽一切办法去除冗余信息。

如果是reduce skew,  一般用两级 hash,



group by keyword+"random string" ) group by substr(  keyword+"random string" )


Redshift performed best in the terabyte range, but Hive caught up and surpassed Redshift in the petabyte range of data.
Redshift is cheaper than Hive

Comparison Chart

| Features                   | Redshift | Hive |
|:----------------------------:|:---------:|:------|
| Open Surce                 | No       | Yes  |
| MapReduce                  | No*      | Yes  |
| Standard SQL               | Yes      | No   |
| Full Administration        | Yes      | No   |
| Support                    | Yes      | Yes  |
| Technical Expertise Needed | No       | Yes  |
| Cloud-base Platform        | Yes      | No** |


