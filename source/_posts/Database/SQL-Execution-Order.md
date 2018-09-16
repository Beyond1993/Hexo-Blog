---
title: SQL Execution Order
date: 2018-09-16 18:23:46
categories: Database
tags:
---

数据库SQL 执行顺序。

1. FROM
2. ON
3. JOIN
4. WHERE
5. GROUP BY
6. WITH CUBE or WITH ROLLUP
7. HAVING
8. SELECT
9. DISTINCT
10. ORDER BY
11. TOP

执行顺序
1. FROM：对FROM子句中前两个表执行笛卡尔积生成虚拟表vt1
2. ON: 对vt1表应用ON筛选器只有满足 join_condition 为真的行才被插入vt2
3. OUTER(join)：如果指定了 OUTER JOIN保留表(preserved table)中未找到的行将行作为外部行添加到vt2，生成t3，如果from包含两个以上表，则对上一个联结生成的结果表和下一个表重复执行步骤和步骤直接结束。
4. WHERE：对vt3应用 WHERE 筛选器只有使 where_condition 为true的行才被插入vt4
5. GROUP BY：按GROUP BY子句中的列列表对vt4中的行分组生成vt5
6. CUBE|ROLLUP：把超组(supergroups)插入vt6，生成vt6
7. HAVING：对vt6应用HAVING筛选器只有使 having_condition 为true的组才插入vt7
8. SELECT：处理select列表产生vt8
9. DISTINCT：将重复的行从vt8中去除产生vt9
10. ORDER BY：将vt9的行按order by子句中的列列表排序生成一个游标vc10
11. TOP：从vc10的开始处选择指定数量或比例的行生成vt11 并返回调用者

![](https://i.stack.imgur.com/GdLq0.png)
