---
title: Ads-Overview
date: 2017-09-20 20:23:06
categories: Ads
tags:
---

CLickZ.com
SearchEngineWatch.com
SearchEngineLand.com

## overview

```text
                           ______________ advertiser __________
                          /                                    \
                 ad_campaign_1          ...                ad_campaign_n
               /             \                            /           \
    ad_group_1   ...   ad_group_n                ad_group_1     ...    ad_group_n
     /      \           /       \               /      \              /      \  
ad_pin_1...ad_pin_n   ad_pin_1...ad_pin_n    ad_pin_1...ad_pin_n   ad_pin_1...ad_pin_n
```

术语：

dimension: 一张表的index
metrics: 根据这样表的index，拿到的信息。

query:
keyword:
cpc:
ctr:
pctr * price ==> 每个impression 可能会获得收益
pctr * 1 ==> 每个impression 可能获得点击次数
eCPM:
stem: 取单词的词根，去掉过去式，将来时态等。
organic pin： 正常的Pin
promotion pin: 广告 Pin
engagement

insertition
action: onsite action 用户的一个操作
attributed_action: offsite action 用户通过点击去一个图片，进入到第三方网站进行操作（例如target),正常情况下我们不知道用户在第三方网站操作了啥，但是如果第三方网站和我们合作，会用javascript 给我们反馈信息

refer
exact match:
broad match:
phrase match: 如果query 是 ‘A B C’, 要找到这个query 对应的 keyword, 对于phrase 来说，先将A B C 拆分成 A, B, C, A B, B C, A B C. 如果其中任意一个match到 keyword, 认为match 成功.
那发过来，有一个 keyword, 只要它是 query 的 sutring, 则认为这个query 一定能match 到这个keyword

