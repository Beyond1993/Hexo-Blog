---
title: Weekly_Diary_6
date: 2017-08-23 18:46:04
categories: 周记
tags:
---
在大数据领域工作也有一个多月了，在Roger的帮助下，学到了很多。

大数据最怕的就是性能问题，跑的慢可怕，跑不出来更可怕。

在跑Hive的时候。总结如下。

1. 对于raw data, 尽量简化代码逻辑

今天遇到一个及其恶心的问题，在算n_candidates的时候，由于算每个月的要花很长时间，我把每两天的作为一个job跑
但是只能同时跑十个，关键是已经cancel的job 貌似还在run. 

2. 而且我的输出文件只有一个000000, 825M，可以将其分成100份。
   方法1. 设置reduce的数量： set mapred.reduce.tasks=10
   方法2. 设置partition
   方法3. 实现custom reducer
mapper 的数量由输入文件数所决定的，所以以后生成中间文件的时候，一定要注意将文件分开来
map 数量一般是不能决定的，但是在网上看到
Mapred.min.split.size
Mapred.max.split.size

Note that on Hadoop 2 (YARN), the mapred.map.tasks and mapred.reduce.tasks are deprecated and are replaced by other variables:

mapred.map.tasks     -->    mapreduce.job.maps 没啥用
mapred.reduce.tasks  -->    mapreduce.job.reduces

**SET hive.merge.mapfiles=false;
SET hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;
SET mapreduce.job.reduces = 1000;**
亲测有效。

3. 分清hive的每个部分，对应的是mapper 还是 reducer
select *  <==> mapper
order by <==> reducer
group by <==> reducer   

4. 大数据工作准则
保持对数据的敏感，将工作重心从代码转移到数据本身。随时验证数据的准确性。
了解大数据平台本身特性，更好的完成，优化查询。
将HQL查询，结构化，记录每张表的生成，插入过程。

5. 字段处理，字符串需要lower(trim(query)), 时刻注意除零,infinity
