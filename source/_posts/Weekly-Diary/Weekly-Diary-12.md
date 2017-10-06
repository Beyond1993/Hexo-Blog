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

3. 之前试过想预处理数据，通过set reduce数量，使得文件分割的更多，便于下一步生产更多 map. 直接设置reducer，并且select, 起不到效果， 因为 reduce 会是0， 所以用distinct *
这次的教训，知道数据预处理是多么重要啊。çut 无关列，去重。 减小数据规模

4. 设置 reducer的数量，要根据下一步怎么处理数据来决定

5. 今天才发现了以前埋的一颗雷. 一开始的log 里就有country 这个值了。


