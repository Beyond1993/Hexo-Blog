---
title: Optimization
date: 2017-10-05 18:31:55
categories: BigData
tags:
---

1. 预处理
预处理的重要程度，怎么强调都不过分.

没有进过预处理的数据，很可能跑十几个小时也跑不出来。或者就算跑出来，也很难在下一步中使用.

预处理原则:
a. 去重。不去重的话join过程可能就是几十倍的cost.
b. 去掉无用的列。出去无关数据.
c. remove null, empty, stem and remove duplication, remove too long, invalid value. 尤其是NULL, empty, 会造成数据倾斜.


2. 逻辑，具体说就是JOIN 操作。
JOIN 操作的时间复杂度是 O(n^2). 在实际工程中，O(n^2) 的时间复杂度应该算是很差的一个解决方案了，但是JOIN 操作，就是O(n*m)

假设table1 n rows, table2 m rows.
table1 里多一条重复，join 操作，就要多 1*m 次, table1 里多一条invalid 数据， join 之后就要多 1 * m条 invalid 数据。

所以在join 之前，确保 table1 table2 已经是最优解。


多表join,
