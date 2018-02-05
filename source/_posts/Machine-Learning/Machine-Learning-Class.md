---
title: Machine Learning Class
date: 2018-02-05 05:41:44
categories: Machine-Learning
tags:
---

Tea老师的上课预习资料和准备：

1. 搭建iPyhon notebook环境（个人建议不要使用conda、enthought canopy等封装库，从而培养对python环境的认识）：
Linux/Mac系统:
https://jupyter.org/install.html
Windows系统：
http://richardt.name/blog/setting-up-ipython-notebook-on-windows/
对于一些在Linux/Mac下用pip install很容易安装的软件包，在windows下可能会失败。这时需要从以下链接下载pre-built版本的安装包，再用pip安装：
https://www.lfd.uci.edu/~gohlke/pythonlibs/


注：
1) 对于有一定python编程经验，且习惯使用IDE的同学，可以考虑下载Pycharm（学生可以免费使用Pycharm专业版）：
https://www.jetbrains.com/pycharm/
，并且在pycharm内搭建iPython notebook:
https://www.jetbrains.com/help/pycharm/using-ipython-jupyter-notebook-with-pycharm.html
2) 无须纠结使用Python2还是3，在实际上手中两者区别并不大。由于我敲命令的时候懒得再多敲一个3，所以个人推荐使用python2 ：）

2. Python （主要是numpy）的基础知识：
http://cs231n.github.io/python-numpy-tutorial/
，可以配合iPython notebook上手做些基本练习：
https://github.com/kuleshov/cs228-material/blob/master/tutorials/python/cs228-python-tutorial.ipynb

3. 安装Tensorflow:
没有比官方文档更合适作Tensorflow的安装教程了：
https://www.tensorflow.org/install/

注：由于我们上课时没法等待模型训练的结果，一般的操作展示tensorflow-cpu版本其实就够了。对于有条件的同学（如带有Nvidia显卡的笔记本/台式机）：强烈建议安装tensorflow-gpu版本，这样最起码自己能够跑出inference的结果。

4. Machine Learning/Neural Network在图像方面应用的基础知识：
斯坦福大学cs231n的教程提供了非常简洁、易懂的介绍：
http://cs231n.github.io/
对于第一节课我们只需要参看*Module 1*，尤其是关于梯度下降、反向传播的内容。

5. Tensorflow的简单代码展示：
官方教程：
https://www.tensorflow.org/tutorials/
以及网上现有的中文教程：
https://zhuanlan.zhihu.com/p/30487008

安装 Jupyter :
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-jupyter-notebook-to-run-ipython-on-ubuntu-16-04

把图片放在代码一个目录下.



