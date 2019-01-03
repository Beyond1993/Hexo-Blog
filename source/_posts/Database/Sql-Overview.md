---
title: Sql-Overview
date: 2019-01-03 02:13:04
categories: Database
tags:
---

数据库是一个软件，用于将数据有组织有纪律地存放在一起。sql 是操作数据库软件的命令。

sql 的基本操作 增删改查

## create table
```sql
CREATE TABLE student (
    Age int,
    FirstName varchar,
    LastName varchar
);
```

## 增
```sql
INSERT INTO student (18, Yixuan, Fan);
INSERT INTO student (19, Wei, Feng);
```

## 删
```sql
DELETE FROM student WHERE Age = 18
```

## 改
```sql
UPDATE student
SET Age = 17, FirstName = 'Xiaoxuan'
WHERE LastName = 'Fan' ;
```

## 查
```
SELECT select_list [ INTO new_table ]

[ FROM table_source ] [ WHERE search_condition ]

[ GROUP BY group_by_expression ]

[ HAVING search_condition ]

[ ORDER BY order_expression [ ASC | DESC ] ]
```

Having 先不用管


## Join
https://www.w3schools.com/sql/sql_join.asp

refer:

https://docs.microsoft.com/en-us/sql/t-sql/queries/select-transact-sql?view=sql-server-2017
