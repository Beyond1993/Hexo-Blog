---
title: Gini Entropy Rate of entropy increase
date: 2017-12-28 07:06:57
categories: Machine-Learning
tags:
---


在ID3算法中我们使用了信息增益来选择特征，信息增益大的优先选择。在C4.5算法中，采用了信息增益比来选择特征，以减少信息增益容易选择特征值多的特征的问题。但是无论是ID3还是C4.5,都是基于信息论的熵模型的，这里面会涉及大量的对数运算。能不能简化模型同时也不至于完全丢失熵模型的优点呢？有！CART分类树算法使用基尼系数来代替信息增益比，基尼系数代表了模型的不纯度，基尼系数越小，则不纯度越低，特征越好。这和信息增益(比)是相反的。

![](https://pic1.zhimg.com/50/v2-3525b5e1845637ed3185e89fb597ca4e_hd.jpg)

从上图可以看出，基尼系数和熵之半的曲线非常接近，仅仅在45度角附近误差稍大。因此，基尼系数可以做为熵模型的一个近似替代。而CART分类树算法就是使用的基尼系数来选择决策树的特征。同时，为了进一步简化，CART分类树算法每次仅仅对某个特征的值进行二分，而不是多分，这样CART分类树算法建立起来的是二叉树，而不是多叉树。这样一可以进一步简化基尼系数的计算，二可以建立一个更加优雅的二叉树模型。

作者：XZH.小章鱼
链接：https://www.zhihu.com/question/36659925/answer/223255104
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
作者：XZH.小章鱼
链接：https://www.zhihu.com/question/36659925/answer/223255104
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。