---
title: Weekly-Diary-12
date: 2017-10-02 18:23:55
categories: 周记
tags:
---

1. 难得周一没bug

2. 今天越到跑HIVE以来最棘手的问题了。 数据量实在是太大了。超过 100 million, 普通的几万级别的reducer 数量跑了7个小时。
JOIN之后更是达到了1 tillion. map 跑了一个小时，才到1%
尝试了几十万的reducer
