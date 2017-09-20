---
title: Weekly-Diary-8
date: 2017-09-08 05:01:40
categories: 周记
tags:
---

这一周主要搞了一个亚马逊OA1

1. 如何解决实际工作中遇到的问题。尤其在数据处理的过程中，当读取现有数据存在困难时，无非就是两个方面，上游，下游。
要么从上游的原始数据找，要么自己生成一个下游，今天遇到的问题，想从Hive 读取一个HFile的key value 信息，但是Hive ignore key while 
reading. 要么自己重新生成这个数据，要么查看原始数据。

2. 访问API 的时间间隔？这次 time.sleep(0.1) 感觉好慢 

3. 记录一下Ads的术语
 
                                   ______________ advertiser __________
                                  /                                    \
                         ad_campaign_1        ...                ad_campaign_n
                       /             \                            /           \
            ad_group_1   ...   ad_group_n             ad_group_1     ...    ad_group_n
             /      \           /       \               /      \              /      \  
        ad_pin_1...ad_pin_n   ad_pin_1...ad_pin_n    ad_pin_1...ad_pin_n   ad_pin_1...ad_pin_n


dimension: 一张表的index
metrics: 根据这样表的index，拿到的信息。

query:
keyword:
cpc:
ctr:
eCPM:
stem: 取单词的词根，去掉过去式，将来时态等。
organic pin： 正常的Pin
promotion pin: 广告 Pin

[refer](https://support.google.com/adwords#topic=3119071)
exact match:
broad match:
phrase match: 如果query 是 'A B C', 要找到这个query 对应的 keyword, 对于phrase 来说，先将A B C 拆分成 A, B, C, A B, B C, A B C. 如果其中任意一个match到 keyword, 认为match 成功.
              那发过来，有一个 keyword, 只要它是 query 的  sutring, 则认为这个query 一定能match 到这个keyword 

4. 检查一张表
select count(*) from 
(
select adgroup from wfeng.table1 group by adgroup
);

----1039749
select count(*) from 
(
select adgroup, keyword from wfeng.table1 group by adgroup,keyword
);

----1039798
select count(*) from 
(
select campaign, adgroup, keyword from wfeng.table1 group by adgroup, campaign, keyword
);


select count(*) from 
(
select keywordlandingpage, adgroup, keyword, campaign from wfeng.table1 group by adgroup, keywordlandingpage, keyword, campaign
);

select count(*) from 
(
select keywordlandingpage, adgroup, keyword from wfeng.table1 group by adgroup, keywordlandingpage, keyword
);

select collect_list(campaign) as campaign, adgroup  from wfeng.table1 group by adgroup;

select collect_set(campaign) as campaign, adgroup  from wfeng.table1 group by adgroup;

 


