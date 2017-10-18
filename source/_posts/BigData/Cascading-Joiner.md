---
title: Cascading-Joiner
date: 2017-08-22 22:03:51
categories: BigData
tags: Cascading
---
四种Join

1. inner join
2. left join
3. right join
4. outer join
5. cross join 

其中cross join 是最少用的，因为是笛卡尔积的运算，所以行数增加到了N * M 行,但是一般join操作都是用来过滤数
[Cascading-Join](http://docs.cascading.org/cascading/1.2/userguide/html/ch03s02.html)

1. inner join
2. left join
3. right join
4. outer join
5. mixed join 3 or more tuples stream
6. custom join

Join 的两个Pipe的Fields不能有重复。
```java
Fields lhsFields = new Fields( "fieldA", "fieldB" );
Fields rhsFields = new Fields( "fieldC", "fieldD" );
Pipe join = new CoGroup( lhs, lhsFields, rhs, rhsFields, new InnerJoin() );
```
最终结果会拼接扩展成:
Fields( "fieldA", "fieldB", "fieldC", "fieldD" );

如果有重复，需要自己重定义定义输出变量名
```java
Fields common = new Fields( "url" );
Fields declared = new Fields( "url1", "word", "wd_count", "url2", "sentence", "snt_count" );
Pipe join = new CoGroup( lhs, common, rhs, common, declared, new InnerJoin() );
```
