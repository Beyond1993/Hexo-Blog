---
title: Java-Overview
date: 2017-10-16 05:59:48
categories: Java
tags:
---

java 在运行时找不到类



我之前都是直接把缺失的类放到 /jre/lib/ext 目录下。但这并不是一个好的解决方案



-classpath 

 

javac  -classpath 参数 和写环境 变量 $CLASSPATH 时 ，要写出path/XXX.jar 全名，只写路径还是找不到。

因为 -classpath 和 $CLASSPATH 都是 找的 .class 文件 ，而 .jar 可以看做是一个文件夹。
