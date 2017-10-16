---
title: Cascading-Configuration
date: 2017-10-16 05:41:23
categories: BigData
tags:
---

官网的文档 貌似更新到15 年，一开始装有些问题．

ubuntu: 14.04

openjdk-7-jdk apt-get install

gradle-1.12 binary-release

hadoop: 2.4.1 binary-release



git clone ../impati



cd Impatiant

gradle clean jar

cd part1





Anatomy:

  source taps       SQL          J2EE          SAS for prediction model       sink taps

data sources --> ETL --> data prep --> prediction model ----------------> end uses.

                         SQLPlanner                                                                            PMMLPlanner



java sample code:



word count - conceptual flow diagram

                                                Map                                                Reduce

Document Collection ------------> Tokenize --------->Groupby token--------------->Count-------->word count

 1 map 1 reduce 18 lines  code



sql in cascading

PMML in cascading with R ?



首要概念：



Tap:数据源 mongodb hbase jdbc

Pipe

Fields

Each

Every
















