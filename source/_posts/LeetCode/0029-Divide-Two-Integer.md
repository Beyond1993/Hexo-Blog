---
title: 0029-Divide-Two-Integer
date: 2017-10-16 07:41:46
categories: LeetCode
tags:
---

不用乘除取模来计算除法

最直观的思路，就是减，一直减，看能减多少次。

为了加速这一过程，使用2分法，使减的数量乘2，当大于被除数时，则从头开始。
