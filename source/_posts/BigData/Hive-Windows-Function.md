---
title: Hive-Windows-Function
date: 2017-09-07 16:54:44
categories: BigData
tags:
---

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


```sql
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

SELECT cookieid, createtime, url, 
       ROW_NUMBER() OVER(PARTITION BY cookieid ORDER BY createtime) AS rn,
       LAG(createtime,1,'1970-01-01 00:00:00') OVER(PARTITION BY cookieid ORDER BY createtime) AS last_1_time
       --LAG(createtime,2) OVER(PARTITION BY cookieid ORDER BY createtime) AS last_2_time
       FROM wfeng.learn_window_function;
       


SELECT cookieid, createtime, url, count(url) OVER(PARTITION BY cookieid ORDER BY createtime 
ROWS between unbounded preceding and unbounded following) AS rn 
FROM wfeng.learn_window_function;

SELECT cookieid, createtime, url, 
       --count(url) OVER(PARTITION BY cookieid ORDER BY createtime rows  between unbounded preceding and current row) AS rn
       --count(url) OVER(PARTITION BY cookieid ORDER BY createtime ROWS between unbounded preceding and current row) AS rn
       --LAG(createtime,1,'1970-01-01 00:00:00') OVER(PARTITION BY cookieid ORDER BY createtime) AS last_1_time
       FROM wfeng.learn_window_function;
```

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











