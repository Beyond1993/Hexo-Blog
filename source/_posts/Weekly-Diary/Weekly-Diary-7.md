---
title: Weekly-Diary-7
date: 2017-08-28 21:19:56
categories: 周记
tags:
---
The first bug related to the scala compile version.

1. Judge is most import than action
今天遇到一个编译问题，最终是因为check sytle的问题，一开始总以为是语法问题。
真是too young too naive.

2. 这两天run cascading job, 总结了工作中犯的错误
string,字符串是串联各个不同程序的重要桥梁。所以在要求字符串一致的地方，只能复制粘贴
debug, 从今以后，不要妄想简单的print 可以找到问题的根源，能单步的一定要单步。
debug, 一定要先确认问题所在，再开始动手调试

3. 系统设计。这次把hive job 扩展成daily -> weekly -> monthly
尽量在daily层，将所有业务逻辑封装好。提供统一的向上接口，简化weekly, monthly查询代码  
这样的话，我就知道每天的所有的metric.之前在考虑系统设计或者写代码的时候，总是优先考虑performance,
估计这是leetCode 刷题后遗症。还需要考虑每一步清晰的逻辑

4. 今天遇到一个极为蛋疼的python bug, 没想到是版本问题，再遇到奇怪的问题，考虑版本，尤其是python 这种。版本大不一样的语言

5. 我一定要搞清楚，hadoop的map reduce 到底是怎么分配的
Map是根据block的大小和文件的数量，那reduce呢？
这里面很实际的问题就是，我什么时候需要自己设置,reduce 数量。

对于一个ads log,这次跑的map reduce 数量是227260, 而我自己设置量reduce 为 1000? 是否最优？  

17/09/01 22:48:13 INFO exec.Task: 2017-09-01 22:48:13,281 Stage-2 map = 100%,  reduce = 99%, Cumulative CPU 215711.48 sec
17/09/01 22:48:14 INFO exec.Task: 2017-09-01 22:48:14,335 Stage-2 map = 100%,  reduce = 100%, Cumulative CPU 206914.61 sec
17/09/01 22:48:22 INFO exec.Task: MapReduce Total cumulative CPU time: 2 days 9 hours 28 minutes 34 seconds 610 msec
17/09/01 22:48:22 ERROR exec.Task: Ended Job = job_1501651753784_149220 with errors
17/09/01 22:48:24 INFO impl.YarnClientImpl: Killed application application_1501651753784_149220
17/09/01 22:48:24 INFO log.PerfLogger: <PERFLOG method=FailureHook.com.pinterest.hive.hooks.SingerLoggingHook from=org.apache.hadoop.hive.ql.Driver>
17/09/01 22:48:24 INFO log.PerfLogger: </PERFLOG method=FailureHook.com.pinterest.hive.hooks.SingerLoggingHook start=1504306104726 end=1504306104727 duration=1 from=org.apache.hadoop.hive.ql.Driver>
17/09/01 22:48:24 ERROR ql.Driver: FAILED: Execution Error, return code 2 from org.apache.hadoop.hive.ql.exec.mr.MapRedTask
17/09/01 22:48:24 INFO log.PerfLogger: </PERFLOG method=Driver.execute start=1504300641792 end=1504306104729 duration=5462937 from=org.apache.hadoop.hive.ql.Driver>
17/09/01 22:48:24 INFO ql.Driver: MapReduce Jobs Launched: 
17/09/01 22:48:24 INFO ql.Driver: Stage-Stage-1: Map: 227260  Reduce: 1000   Cumulative CPU: 2974595.21 sec   HDFS Read: 14589919508 HDFS Write: 482469565493 SUCCESS
17/09/01 22:48:24 INFO ql.Driver: Stage-Stage-2: Map: 1000  Reduce: 1000   Cumulative CPU: 206914.61 sec   HDFS Read: 482478116869 HDFS Write: 0 FAIL
17/09/01 22:48:24 INFO ql.Driver: Total MapReduce CPU Time Spent: 36 days 19 hours 45 minutes 9 seconds 820 msec
17/09/01 22:48:24 INFO log.PerfLogger: <PERFLOG method=releaseLocks from=org.apache.hadoop.hive.ql.Driver>
17/09/01 22:48:24 INFO log.PerfLogger: </PERFLOG method=releaseLocks start=1504306104730 end=1504306104730 duration=0 from=org.apache.hadoop.hive.ql.Driver>
17/09/01 22:48:24 ERROR operation.Operation: Error running hive query: 
org.apache.hive.service.cli.HiveSQLException: Error while processing statement: FAILED: Execution Error, return code 2 from org.apache.hadoop.hive.ql.exec.mr.MapRedTask
    at org.apache.hive.service.cli.operation.Operation.toSQLException(Operation.java:328)
    at org.apache.hive.service.cli.operation.SQLOperation.runQuery(SQLOperation.java:181)
    at org.apache.hive.service.cli.operation.SQLOperation.access$100(SQLOperation.java:70)
    at org.apache.hive.service.cli.operation.SQLOperation$1$1.run(SQLOperation.java:232)
    at java.security.AccessController.doPrivileged(Native Method)
    at javax.security.auth.Subject.doAs(Subject.java:415)
    at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1657)
    at org.apache.hive.service.cli.operation.SQLOperation$1.run(SQLOperation.java:244)
    at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:471)
    at java.util.concurrent.FutureTask.run(FutureTask.java:262)
    at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
    at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)
    at java.lang.Thread.run(Thread.java:745)

数据已经写完了。

6. 来Pinterest广告组也有一个多月了，这一个多月，总是疲于奔命，学东西，写代码，调bug.乘着这次休假，好好的思考一下。
ad的含义，为什么这些东西可以赚钱.


7. 修复Partition : MSCK REPAIR TABLE db.table1;
