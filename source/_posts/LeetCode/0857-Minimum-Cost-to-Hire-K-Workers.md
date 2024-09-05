---
title: 857. Minimum Cost to Hire K Workers
date: 2024-06-09 04:34:56
categories: LeetCode
tags:
---

https://www.youtube.com/watch?v=3a_HFrdpjos


招K个人，要求付的工资综合最低。

注意这里的要求是K个人，工资最低，并没有要求产出最高。

但是要满足两个条件：
1.  最低工资原则：就是每个人不能低于他所预期的单位工资
2. 公平原则：同工同酬，多劳多得。如果定义单位工资为R， 一个人的工资必须是这个的整数倍

由此可推断，R 必须是 k 个人里单位工资最高的才能满足两个条件。


这就是一个典型的贪心算法，先找出最低ratio 的人，再在这K 个人去掉quality 最多的

枚举所有可能答案group里最差的那个ratio的情况, 然后考虑怎么保留其余的worker（剔除最大quality)
