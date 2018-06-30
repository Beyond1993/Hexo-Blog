---
title: Neural-Network
date: 2017-12-05 21:28:11
categories: Machine-Learning
tags:
---

http://www.ruanyifeng.com/blog/2017/07/neural-network.html

阮一峰老师真是深入浅出的大师，遇到什么难懂的概念，看到他的博客，心里就轻松了一半

神经网络。

神经网络的本质就是一个"思考"的过程, 就是一个不断调整threshold weight的过程

神经网络的起源：感知器
上世纪六十年代提出 感知器(perceptron), 也就是 人造神经元 artificial neuron 的概念. 

![](http://www.ruanyifeng.com/blogimg/asset/2017/bg2017071202.png)

从某种程度来看,感觉有点像与非门的运算. 再从编程的角度来看，输入输出，只不过是这个function的“代码” 会随着输入的改变而改变。

weight threshold
对于每个输入的变量，权重是不一样的.
而阈值觉得了输出的结果

最简单的网络是一个神经元就够了，但是应对到生活中的实际问题，往往需要大量的神经元组合起来做决策。


神经网络几大模块:

Activation function
sigmoid function
tanh function
softmax function
rectified linear unit function

https://www.zhihu.com/question/34681168/answer/84061846

DNN 深度神经网络
CNN 卷积神经网 空间上的深度神经网 在图像处理中应用广泛
RNN 循环神经网络 时间上的深度神经网 Recurrent Nerual Networks for sequence data
循环神经网络 在自然语言处理中得到了广泛的应用，因为他是模拟人脑， 可以记录上下文的关系，而不是从头来过.

LSTM: Long short term memory networks
卷积的

