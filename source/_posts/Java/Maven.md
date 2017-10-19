---
title: Maven
date: 2017-08-28 02:57:00
categories: Java
tags:
---
# Maven 详解
[常用命令](http://blog.csdn.net/naruto_ahu/article/details/10099079)
[命令行参数](http://blog.csdn.net/wangjunjun2008/article/details/18982089)


ubuntu 16.04



一. 查看maven 版本

$ mvn --version



sudo apt-get install maven



maven 要求是 3.0以上



二. 创建标准化java项目



1). 用Maven创建一个标准化的Java项目

$ cd workSpace

$ mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=org.pca -DartifactId=myMahout -DpackageName=org.conan.mymahout -Dversion=1.0-SNAPSHOT  -DinteractiveMode=false

$ cd myMahout

$ mvn clean install



archetype:

-DarchetypeGroupId:

-DgroupId:"groupId”属性是一个组织或者项目（比如开源项目）的唯一ID。大多数情况下，你会使用项目的java包的根名称作为group ID。例如，对于我自己的Java网络爬虫项目，我会使用com.jenkov作为group ID。如果这个项目是一个由很多独立的贡献者组成的开源项目，也许选择与项目相关的名称作为group ID，比选择与我的公司相关的名称名作为group ID要合理地多。因此，选择com.javawebcrawler作为group ID

-DartifactId:包含你正在构建的项目的名称.

-DpackageName:

-Dversion:

-DinteractiveMode:



  4.0.0  org.conan.mymahout  myMahout  jar  1.0-SNAPSHOT  myMahout  http://maven.apache.org          UTF-8        0.10.0    
          junit      junit      3.8.1      test          org.apache.mahout    mahout-math    ${mahout.version}      org.apache.mahout    mahout-core    0.9    org.apache.mahout    mahout-hdfs    ${mahout.version}                    org.apache.hadoop                hadoop-client                2.6.0                                org.apache.hadoop                hadoop-common                2.6.0                                org.apache.hadoop                hadoop-hdfs                2.6.0                org.apache.maven.plugins        maven-compiler-plugin                    1.7            1.7


$ mvn clean install

$ mvn compile

mvn clean package -pl hadoop -DskipTestsi -Dcheckstyle.skip=true
