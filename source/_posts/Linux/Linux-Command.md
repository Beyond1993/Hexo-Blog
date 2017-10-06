---
title: Linux-Command
date: 2017-08-27 16:53:57
categories: Linux
tags:
---
## touch
touch 用来更新原文件时间，文件没有则创建新文件
## find
find 命令默认是递归的

按文件名查找：
find ./ -name "filename"
find ./ -name "*.class"

更新文件：
find ./ -exec touch {} \;
-exec 后面是一个表达式,{} 代表前找到的文件, ;是表达式终止符，不加\, ;会被当作find 整体的一部分处理 find ;

查找某一类文件的大小:
find ./ -name "*.class" -exec du -ch {} + | grep total

查找每一类文件的个数:
find . -name "*.java" | wc -l 

## grep egrep
[正则查找](http://www.cnblogs.com/hfutwyy/p/3415577.html)
egrep -r  'Daily.+HiveJob' *

## 截取列
-d 指定分隔符， -f 指定第几列
cut -d , -f 2-51 bulk_editor_test.csv > bulk_temp.csv
