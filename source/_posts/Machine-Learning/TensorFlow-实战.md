---
title: TensorFlow 实战
date: 2017-12-28 18:05:25
categories: Machine-Learning
tags:
---

## 1 TensorFLow 基础

tensorFlow 三大属性

regular seesion
interactive session

DistBelief --> TensorFlow

### 1.1 TensorFlow 概要
### 1.2 TensoFlow 编程模型简介
TensorFlow 中的计算可以表示为一个有向图(directed graph), 或称计算图(computation graph), 其中每一个运算操作(operation) 将作为一个节点(node),节点与节点之间的连接称为边(edge)

计算图中每一个节点可以有任意多个输入和任意多个输出，每一个节点描述了一种运算操作，节点意义算是运算操作的实例化(instance)。在计算图的边中流动(flow) 的数据被称为张量(tensor)，故得名 TensorFlow。

## 2 TensorFlow 和其他深度学习框架对比
### 2.1 主流深度学习框架对比
### 2.2 各深度学习框架对比

## 3 TensorFlow 第一步
### 3.1 TensorFlow 的编译与安装
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

#### Softmax Regression 算法
数字都是0~9之间的，一共有10个类别，当对图片进行预测时，Softmax Regression 会对每一种类别估算一个概率，并将概率最大的那个数字作为结果输出。

Softmax Regression 将可以判定为某类的特征相加，然后将这些特征转化为判定是这一个类的概率。我们对图片的所以像素求一个加权和。如某个像素的灰度值大代表很有可能是数字n，这个像素权重就很大，反之，这个权重很有可能为负值。

特征公式：

![](http://img.blog.csdn.net/20170409151626622?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

bi 为偏置值，就是这个数据本身的一些倾向。

然后用 softmax 函数把这些特征转换成概率 y :

![](http://img.blog.csdn.net/20170501145450370?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

对所有特征计算 softmax，并进行标准化（所有类别输出的概率值和为1）：

![](http://img.blog.csdn.net/20170409151939330?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

判定为第 i 类的概率为：

![](http://img.blog.csdn.net/20170409152012628?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

Softmax Regression 流程如下：
![](http://img.blog.csdn.net/20170409152135564?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

转化为矩阵乘法:

![](http://img.blog.csdn.net/20170409152219236?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

![](http://img.blog.csdn.net/20170409152232689?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

写成公式如下：

![](http://img.blog.csdn.net/20170409152318115?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDg1ODYwNQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)



[为什么取对数](https://stackoverflow.com/questions/17187507/why-use-softmax-as-opposed-to-standard-normalization)

杨宏也大神说这是数学推出来的，一方面可以保证非线性化

为了训练模型，我们需要定义loss function 来描述模型对问题的分类精度。Loss 越小，代表模型的分类结果与真实值的偏差越小，也就是说模型越精确，训练目的就是不断将这个loss 减小，直到达到一个全局最优或者局部最优解。

对于多分类问题，通常使用cross-entropy 作为 loss function。

现在我们有了算法Softmax Regression, 又有了损失函数 cross-entropy,
只需定义一个优化算法即可开始训练。我们采用常见的随机梯度下降SGD(Stochastic Gradient Descent)

这是一个非常简单的例子，我们使用TensorFlow 实现简单的机器学习算法Softmax Regression, 这可以算作一个没有隐含层的最浅的神经网络。

一般DL的工作流程：

(1) 定义算法公式，也就是神经网络forward 时的计算。
(2) 定义 loss，选定优化器，并指定优化器优化loss。
(3) 迭代地对数据进行训练。
(4) 在测试集或验证集上对准确率进行评测。

```python
import tensorflow as tf 

from tensorflow.examples.tutorials.mnist import input_data

mnist = input_data.read_data_sets("MNIST_data/",one_hot=True)

print(mnist.train.images.shape,mnist.train.labels.shape)
print(mnist.test.images.shape,mnist.test.labels.shape)
print(mnist.validation.images.shape,mnist.validation.labels.shape)

x = tf.placeholder(tf.float32, [None, 784])

W = tf.Variable(tf.zeros([784,10]))
b = tf.Variable(tf.zeros([10]))

y = tf.nn.softmax(tf.matmul(x,W)+b)

y_ = tf.placeholder(tf.float32,[None,10])
#cross_entropy = -tf.reduce_sum(y_*tf.log(y))
cross_entropy = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y)))
                              
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

init = tf.initialize_all_variables()
sess = tf.Session()
#tf.global_variables_initializer().run(session=sess)
with sess.as_default():
    sess.run(init)
    for i in range(1000):
        batch_xs,batch_ys = mnist.train.next_batch(100)
        train_step.run({x:batch_xs,y_:batch_ys})
        #train_step.run({x:batch_xs,y:batch_ys})
        #sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys}) 
    correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction,tf.float32))
    print(accuracy.eval({x:mnist.test.images,y_:mnist.test.labels}))
```

## 4 TensoFlow 实现自编码及多层感知机
### 4.1 自编码器
传统机器学习任务很大程度上依赖于好的特征工程，比如对数值，日期时间型，种特征等特征的提取。工程师必须在这些领域有非常深入的理解。
### 4.2 TensorFlow 实现自编码器
### 4.3 多层感知机简介
### 4.4 TensorFlow 实现多层感知机

自编码器(AutoENcoder) 顾名思义，即可以使用自身的高阶特征编码自己。
## 5 TensorFLow 实现卷积神经网络
### 5.1 卷积神经网简介
卷积神经网络 (Convolutional Neural Network) 最初是为了解决图像识别而设计的，现在也应用于时间序列信号，比如音频信号，文本数据等。

在深度学习出现之前，我们必须借助SIFT, HoG 等算法提取具有良好分区性的特征，再集合SVM 等机器学习算法进行图像识别。

卷积神经网络提取的特征不需要将特征提取和分类训练两个过程分开，在训练时就自动提取了最有效的特征。

CNN 可以直接使用图像原始数据作为输入，降低对图像数据预处理的要求, 以避免复杂的特征工程。

### 5.2 TensorFLow 实现简单的卷积网络
### 5.3 TensorFLow 实现进阶的卷积网络
 
## 6 TensorFLow 实现经典卷积神经网络

## 7 TensorFlow 实现循环神经网络及 Word2Vec

## 8 TesnsorFlow 实现深度强化学习

## 9 TensorBoard, 多 GPU 并行及分布式并行

## 10 TF.Learn 从入门到精通

## 11 TF.Contrib 的其他组件

[Github](https://github.com/JiafengZhou/-tensorflow-)
