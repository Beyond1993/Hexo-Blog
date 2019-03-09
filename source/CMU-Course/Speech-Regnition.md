---
title: Speech-Regnition
date: 2017-12-13 00:18:40
categories: CMU
tags:
---

![](http://img.blog.csdn.net/20140528175313171?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYWJjamVubmlmZXI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

提取语音特征，MFCC (梅尔倒谱系数)

HMM 与有限状态的一阶马尔可夫链
一样地用初始分布、状态转移概率矩阵来描述有限长随机序列的统计特性, 但他不同于马尔可夫链由每
一观察即可确知当前所处状态, 而是由每一观察仅能估算出当前处于各种状态的概率. 这就是说, 它具
有双重随机性, 是一种双重随机过程.

在语音识别中，语音特征作为观察结果，音素作为隐藏状态。 HMM 的作用就是建立了隐藏状态到观察结果之间的联系。

http://blog.csdn.net/abcjennifer/article/details/27346787

而在训练HMM模型的参数时（比如用Baum-Welch算法），每次输入到HMM中的数据要求就是一个观测值序列。这时，每个状态对应的观测值为39维的向量，因为向量中元素的取值是连续的，需要用多维密度函数来模拟，通常情况下用的是多维高斯函数。在GMM-HMM体系中，这个拟合函数是用K个多维高斯混合得到的。假设知道了每个状态对应的K个多维高斯的所有参数，则该GMM生成该状态上某一个观察向量（一帧音频的MFCC系数）的概率就可以求出来了。

http://www.cnblogs.com/tornadomeet/archive/2013/08/23/3276753.html

单高斯，多高斯
segment k-means <--> HMM

那问题来了， 为什么非要通过GMM train model？ 而不是直接把数据喂给HMM

拟合mfcc点的分布，这样在后面就可以算一个特定点在这个分布底下的概率密度。

直观来讲就是可以算距离?

通过delta 拓展 mfcc 向量。引入速度和加速度的信息，使得特征有更丰富的表达能力。



