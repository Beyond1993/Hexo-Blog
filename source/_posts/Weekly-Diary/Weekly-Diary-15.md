---
title: Weekly-Diary-15
date: 2017-10-22 21:17:00
categories: 周记
tags:
---

这个周末真是被not a sequenceFile 这个bug 给恶心到了，
```sql
DROP TABLE wfeng.keyword_planning_metrics_hfile;
ADD JAR s3n://qubole-pinterest/hadoop_users/prod/hadoop-0.1-SNAPSHOT/hadoop-0.1-SNAPSHOT.jar;
CREATE EXTERNAL TABLE wfeng.keyword_planning_metrics_hfile
 PARTITIONED BY (dt STRING)
 ROW FORMAT SERDE 'com.pinterest.hadoop.hive.SimpleThriftSerDe'
    WITH SERDEPROPERTIES('thrift_type'='com.pinterest.keyword_planning_common.thrift.KeywordDeliveryList')
 STORED AS
    INPUTFORMAT 'com.pinterest.hadoop.hfile.StreamingHFileInputFormat'
    OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
 LOCATION   's3n://pinlogs/users/wfeng/keyword_planning_metrics_hfile/';
```

创建的时候，一定要注意。INPUTFORMAT 'com.pinterest.hadoop.hfile.StreamingHFileInputFormat'
    OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'

这两句话

