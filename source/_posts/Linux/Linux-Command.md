---
title: Linux-Command
date: 2017-08-27 16:53:57
categories: Linux
tags:
---

ls -lh filename 以 K M G 查看文件大小

配置  .vimrc

vim ~/.vimrc (need touch if the file does not exist)

set number
syntax on
set a


慎用 apt-get autoremove



一. 快速移动篇

按行号移动

nG         //移动到第n行，注意此处G是大写。即输入n，在小写模式下输入shift+g，大写模式下直接按下g键(如100G则能快速定位到源程序中第100行代码位置处，想必是很有用的。）

Ctrl + g  // 显示当前行（并不是移动命令）

G            // 移动到文件的尾部，在小写模式下输入shift+g，大写模式下直接按下g键

gg         //move to file top



按字符移动

fx       //往右移动到 x 字符上                                                         

Fx       //往左移动到 x 字符上                                                         

tx       //往右移动到 x 字符前                                                         

Tx      //往左移动到 x 字符后            



;         //分号，配合 f 和 t 使用，重复一次                                        

,         //逗号，配合 f 和 t 使用，反方向重复一次  o





二.编辑：

http://www.cnblogs.com/nerxious/archive/2012/12/21/2827774.html

i   当前位置插入

O 上一行插入

o 小o， 下一行插入



y5h--> p   yank back 5 characters  and then paste





三.搜索, 替换

/pattern            // 向前搜索模式，pattern代指要搜索的内容

?pattern            // 向后搜索模式

n                              // 重复上次搜索（向行号大的方向）

N                             // 反方向重复上次搜索




替换

：%s/from/to/g   有%是全文替换，没有%是当前行替换，s即substitude，将from替换成to, 加 /g  是对这一行每个from 都替换成to， 不加/g 之替换这一行第一个出现的from

例：替换每一行行号，用正则

：%s/[0-9]\./ / g                 将 [0-9]\.  (如 8.) 替换成 空格







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


创建桌面快捷方式
ln -s /home/wayne/eclipse/jee-neon/eclipse/eclipse  ~/Desktop/


查看进程
psef dlibmg

look up the size of current folder

du -sh *
