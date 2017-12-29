---
title: TensorFlow 实战
date: 2017-12-28 18:05:25
categories: Machine-Learning
tags:
---

## TensorFLow 基础

DistBelief --> TensorFlow

### 1.2 TensoFlow 编程模型简介
TensorFlow 中的计算可以表示为一个有向图(directed graph), 或称计算图(computation graph), 其中每一个运算操作(operation) 将作为一个节点(node),节点与节点之间的连接称为边(edge)

计算图中每一个节点可以有任意多个输入和任意多个输出，每一个节点描述了一种运算操作，节点意义算是运算操作的实例化(instance)。在计算图的边中流动(flow) 的数据被称为张量(tensor)，故得名 TensorFlow。

## TensorFlow 和其他深度学习框架对比

## 3 TensorFlow 第一步
### 3.2 TensorFlow 实现 Softmax Regression 识别手写数字

机器学习领域的Hello World 任务---MNIST 手写数字
(Mixed National Institute of Standards and Technology database)

现有几万张 28 * 28 的手写数字的灰度图

训练集有55000 个样本, 测试集有10000 个样本，验证集有5000个样本. 每个样本都有label。

我们在训练集上训练模型，在验证集上检验效果并决定何时完成训练，最后在测试集评测模型效果(可通过准确率，召回率，F1-score 等评测)

**验证集 和 测试集 有什么区别？** 

![](http://img.blog.csdn.net/20160403174832218?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

如上图所示，空白部分全为0，有笔记的地方根据颜色深浅有0 到 1 之间的取值。 我们有 28 * 28 = 784 维的特征向量，这样简单的特征丢失了图片的空间结构信息。但是对于这次的分类任务已经足够了。

后面的章节将使用**卷积神经网络对空间结构信息进行利用**，并取得更高的准确率。 

我们将图片展开成1维向量时，顺序并不重要，只要每一张图片都是同样顺序展开就行。

我们的训练特征是一个 55000 * 784 的 Tensor, 这里是采用了 one-hot 编码, Label 是一个 10 维的向量。

准备好数据后，接下来就是设计算法了， 这里使用 Softmax Regression 的算法。

我们在处理多分类任务时，通常需要使用Softmax Regression 模型，即使是后面的卷积神经网络或者循环神经网络，如果是分类模型，最后一层也同样是Softmax Regression。


[为什么取对数](https://stackoverflow.com/questions/17187507/why-use-softmax-as-opposed-to-standard-normalization)

## TensoFlow 实现自编码及多层感知机

## TensorFLow 实现卷积神经网络

## TensorFLow 实现经典卷积神经网络

## TensorFlow 实现循环神经网络及 Word2Vec

## TesnsorFlow 实现深度强化学习

## TensorBoard, 多 GPU 并行及分布式并行

## TF.Learn 从入门到精通

## TF.Contrib 的其他组件
