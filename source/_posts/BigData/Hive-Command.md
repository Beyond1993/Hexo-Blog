---
title: Hive-Command
date: 2017-09-07 21:40:52
categories: Hive
tags:
---
repair partitions

MSCK REPAIR TABLE default.table_name;

rename partitions

ALTER TABLE partition_test PARTITION (year='2016',day='1') RENAME TO PARTITION (year='2016',day='01');

ALTER TABLE wfeng.monthly_query_userid_volume_feedview PARTITION (dt = '2016-02-01') RENAME TO PARTITION (dt = '2017-02-01');
