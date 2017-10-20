---
title: Hive-Command
date: 2017-09-07 21:40:52
categories: BigData
tags:
---
repair partitions

MSCK REPAIR TABLE default.table_name;

rename partitions

ALTER TABLE partition_test PARTITION (year='2016',day='1') RENAME TO PARTITION (year='2016',day='01');

ALTER TABLE wfeng.monthly_query_userid_volume_feedview PARTITION (dt = '2016-02-01') RENAME TO PARTITION (dt = '2017-02-01');


SET hive.merge.mapfiles = false;
SET hive.input.format = org.apache.hadoop.hive.ql.io.HiveInputFormat;
SET mapred.reduce.tasks = 1000;
SET hive.exec.sink_operator.delete_target_if_exists=true
SET hive.mapred.reduce.tasks.speculative.execution=false;
SET mapreduce.reduce.speculative=false;
