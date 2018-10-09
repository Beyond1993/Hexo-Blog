---
title: 'Mysql-Backup '
date: 2017-10-16 05:55:54
categries: Database
tags:
---

我想把aws上的数据 备份，以便之后快速恢复网站，用最简单的方法备份mysql数据：




使用mysqldump备份一个数据库 


　　mysqldump 语法 


　　mysqldump -u username -p dbname table1 table2 ...-> BackupName.sql 


         


        dbname参数表示数据库的名称； 


        table1和table2参数表示需要备份的表的名称，为空则整个数据库备份； 


        BackupName.sql参数表设计备份文件的名称，文件名前面可以加上一个绝对路径。通常将数据库被分成一个后缀名为sql的文件； 

mysqldump -u rt -p blg > ./blgbackup.sql


table: query_domain

DROP TABLE IF EXISTS `query_domain`;
CREATE TABLE `query_domain` (
  `query` varchar(255) ,
  `domain` char(255)
);


mysqlimport --ignore-lines=1 --fields-terminated-by=, --local -u root -p Database TableName.csv

query_domain.csv

quotes,NoDomain
mothers day gifts,www.personalizationmall.com
mothers day gifts,www.revolve.com
mothers day gifts,www.amazon.com
mothers day gifts,www.williams-sonoma.com
mothers day gifts,www.remembermegiftsonline.com
easter,NoDomain
prom hair,NoDomain
summer outfits,NoDomain
hair styles,www.garnierusa.com
spring outfits,NoDomain
nails,NoDomain
teacher appreciation gifts,www.successories.com
teacher appreciation gifts,www.amazon.com
teacher appreciation gifts,www.target.com
chicken recipes,NoDomain
wedding dresses,www.davidsbridal.com
wedding dresses,www.helenmillerbridal.com
wedding dresses,www.renttherunway.com
wedding dresses,www.jjshouse.com
mysqlimport -u root -pmysql8111249 --fields-terminated-by=',' --lines-terminated-by='\n' --local  wfeng query_domain.csv


DROP TABLE IF EXISTS `query_volume`;
CREATE TABLE `query_volume` (
  `query` varchar(255) ,
  `volume` int
);
INSERT INTO `query_volume` VALUES ('quotes', 5);

INSERT INTO `query_volume` VALUES ('mothers day gifts', 20);

INSERT INTO `query_volume` VALUES ('easter', 4);

INSERT INTO `query_volume` VALUES ('prom hair', 2);

INSERT INTO `query_volume` VALUES ('summer outfits', 0);

INSERT INTO `query_volume` VALUES ('hair styles', 0);

INSERT INTO `query_volume` VALUES ('spring outfits', 6);

INSERT INTO `query_volume` VALUES ('nails', 23);

INSERT INTO `query_volume` VALUES ('teacher appreciation gifts', 2);

INSERT INTO `query_volume` VALUES ('chicken recipes', 20);

INSERT INTO `query_volume` VALUES ('wedding dresses', 20);



//single quote must keep same as creating table 



select a.domain, count(a.query), sum(b.volume) from query_domain a join query_volume b on a.query = b.query  group by a.domain\G;




Join 操作是个很神奇的操作。今天来做个总结。(其实就是两层循环）

table person:

+---------+--------+--------+

 | name  |  age   |  sex               

+--------- |---------|---------

mike      |  34     |  male

wayne   |  24     |  male

mary     |  24     |  female

 

table employer:

name |   title  | salary | age

---------|----------|---------------- 

mike   |   SDE  | 1000  |  34  

bob    |    QA   | 2000  |  24

mary  |    HR   |  500   |  24



join by name

select a.name name, a.age age,  a.sex sex, b.title, b.salary salary, b.age bage  
from person a join employer b on a.name = b.name;
+------+------+--------+-------+--------+------+
| name | age  | sex    | title | salary | bage |
+------+------+--------+-------+--------+------+
| mike |   34 | male   | SDE   |   1000 |   34 |
| mary |   24 | female | HR    |    500 |   24 |
+------+------+--------+-------+--------+------+

其实就是两层循环

select a.name name, a.age age,  a.sex sex, b.title, b.salary salary, b.age bage  
from person a join employer b on a.age = b.age;
+-------+------+--------+-------+--------+------+
| name  | age  | sex    | title | salary | bage |
+-------+------+--------+-------+--------+------+
| mike  |   34 | male   | SDE   |   1000 |   34 |
| wayne |   24 | male   | QA    |   2000 |   24 |
| mary  |   24 | female | QA    |   2000 |   24 |
| wayne |   24 | male   | HR    |    500 |   24 |
| mary  |   24 | female | HR    |    500 |   24 |
+-------+------+--------+-------+--------+------+






INNER JOIN gets all records that are common between both tables

LEFT JOIN gets all records from the LEFT linked table but if you have selected some columns from the RIGHT table, if there is no related records, these columns will contain NULL

RIGHT JOIN is like the above but gets all records in the RIGHT table

FULL JOIN gets all records from both tables and puts NULL in the columns where related records do not exist in the opposite table

Mysql 没有 FULL JOIN 可以用

(SELECT ... FROM tbl1 LEFT JOIN tbl2 ...) UNION ALL 
(SELECT ... FROM tbl1 RIGHT JOIN tbl2 ... WHERE tbl1.col IS NULL)
code:

https://github.com/Beyond1993/Sql/blob/master/Join_Operation.sql



reference:

http://blog.csdn.net/xiao2004/article/details/6562435
