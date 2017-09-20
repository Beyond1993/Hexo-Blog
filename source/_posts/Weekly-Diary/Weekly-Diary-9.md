---
title: Weekly-Diary-9
date: 2017-09-11 05:01:40
categories: 周记
tags:
---

1. 一个hive的代码跑了五个小时。
以后数据量很大的时候，要先分析数据规模。
以这次的为例子。
这次的源数据有三百多G。
主要问题现在是三个很大的表join. 一个是 keyword --> list of keyword, search  query metrics, feed view daily volume

2. 并不一定是reducer 数量愈多愈好，reduce 1000 时，很快跑完的数据，反而在2000时遇到了，data skew
而且，reducer的数量也要根据不同文件大小来确定，一般我设1000 ~ 5000不等
reducer 太多的时候，shuffle 和 reduce 也要花很长时间。
而且 reducer 真正能running的，是有限的

3. 为什么要追求效率，因为代码甚少会一次性写对，除了肉眼调试之外，试错成本也很关键。
```text
   | table size |  reducer number |
   | ---------- |  -------------- |
   | 300G       |     1000        |
```
4. 这两天算是栽在broad match, 和 phrase match 上了。
broad match:
phrase match: 一开始用a like concat('%',b,'%'), 用country 去join. 出现data skew
              先将query explode 成 n-gram
5. data skew
遇到data skew, 首先要分析为什么会出现data skew.
比如这次的phrase match, 很可能出现的keyword是,the, 是很多query 的substring.
可以考虑先将query 拆成 n-gram, 再把像the这样的单词合并。用hive 的equal join.

6. 突然想到了,验证大数据结果的一种方法，先将必须用Hive函数存起来，存成一个表，再将其他部分，用presto跑。

7. 之前估计是因为Roger和我说，Hive写在一起有利于优化，但是这次正是因为把query写在一起，导致错误百出，虽然也有图形化界面的问题。
   但是一段query, 要写的简洁，顺利，也是不容易。

8. 今天和星稚聊天，关于试错成本，其实这种问题何尝不存在我的身上呢。工作上的提升，就是如何尽量提升效率，减少错误。 

9. 终于明白为什么hive table 里只存 bigint 的 clicks, impression, 今天stemmed 之后，发现cpc, cpt 都不能简单的相加取均值。
由此总结出，在Hive的table里，最好只存可以累加的metrics。

10. map 或 reduce的数量虽多，但是同时run的job 数并不多。大概有一千多把。

11. 千万不要直接join 两张很大的表，一来跑了很久没结果 不好调试，如果运行时间超过两个小时的话，就很可能会挂掉

12. 一般一个join 就是一个 stage, 不要尝试join两张很大的表，在从log 里读取字符串的一开始，就做好trim or stem 操作。

13. 在新的结果出来之前， 千万不要删除老版本！！！ 因为新结果很可能跑不出来。这是一个很不好的习惯！

14. select query, cpc, count(*) as num  from wfeng.table1 GROUP BY query, cpc;
select query, cpc, count(-1) as num  from wfeng.table1 GROUP BY query, cpc;
select query, cpc, count(0) as num  from wfeng.table1 GROUP BY query, cpc;
select query, cpc, count(1) as num  from wfeng.table1 GROUP BY query, cpc;
select query, cpc, count(2) as num  from wfeng.table1 GROUP BY query, cpc;
select query, cpc, count(3) as num  from wfeng.table1 GROUP BY query, cpc;

15. join 是一个job, group by是一个 job

16. Hive out join 要在 join on 的条件里指定 partition
