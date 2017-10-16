---
title: 'Mysql-Backup '
date: 2017-10-16 05:55:54
categries:
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
