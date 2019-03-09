---
title: CMU 16720 Spatial Pyramid Matching for Scene Classification
date: 2017-12-14 22:59:27
categories: CMU
tags:
---


Spatial Pyramid Matching for Scene Classification

http://blog.csdn.net/v_JULY_v/article/details/6555899

利用bag-of-words 作分类.

其实词袋模型的原理都简单。 一共分为三步:

1. Bag-of-words模型的第一步是利用SIFT算法，从每类图像中提取视觉词汇。
2. 是利用K-Means算法构造单词表
3. 利用单词表的中词汇表示图像

在海量数据中搜索，将某一类型文档的常出现的词作为这类文档的feature， 

只不过现在这词变成了, 某一图片的feature(至于怎么选一个图片的feature, 则是经典的SIFT 算法)  作为一个vision word，放入这个场景的词袋。

为什么要Spatial Pyramid， 因为，图片有大有小，我们把他分解成一串金字塔，取其中统一规格的

如下图所示，将level(i)的图像划分为pow(4,i) 个cells,然后再每一cell上统计直方图特征，最后将所有level的直方图特征连接起来组成一个vector，作为图形的feature。

![](http://img.blog.csdn.net/20150707105029921?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
