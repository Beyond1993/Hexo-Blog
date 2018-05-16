---
title: TensorFlow 基础
date: 2018-05-16 03:36:37
categories: Machine-Learning
tags:
---

TensorFlow = Tensor + Flow

Tensorflow几大概念：
• Tensor: 网络图中节点的数据传输是通过Tensor的形式进行的。Tensor可以是任意的单个常量、矢量、或者是矩阵（即1维至n维的数组）。
• Session：Tensorflow运行的上下文环境。Tensorflow任何的操作都需要在一个指定的上下文环境中运行。
• Variable：特指在Graph包含的所有变量,也可以理解为任何需要Tensorflow在runtime过程中决定的变量。注：所以变量都需要初始化。
• Graph: 包含一系列操作和数据的图。操作在Tensorflow中同样被表示为Object（tf.Operation），而数据则用tf.Tensor表示。

