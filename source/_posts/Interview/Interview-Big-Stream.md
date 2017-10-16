---
title: Interview-Big-Stream
date: 2017-10-16 06:24:43
categories: 面试
tags:
---

明天就要onsite big stream了． C++ 面试，不管怎么样，都要淡定！沉着



整理一下Ｃ＋＋面试题．



指针和引用



转换类型．



先分为显式和隐式两种类型转换．显示又有四种．隐式转换是Ｃ语言的遗留，应该尽量避免．

四种显示类型转换：

static_cast 不安全

const_cast　去除变量的常量性(const) 和　易变性　(volatitle)

dynamic_cast 失败会返回NULL 或者　抛异常

reinterpret_cast 常用的一个用途是转换函数指针类型，即可以将一种类型的函数指针转换为另一种类型的函数指针，但这种转换可能会导致不正确的结果。总之，reinterpret_cast 只用于底层代码，一般我们都用不到它，如果你的代码中使用到这种转型，务必明白自己在干什么。



references : http://www.cppblog.com/kesalin/archive/2012/10/28/type_cast.html



虚函数列表：



1 听说过C++
常见的问题 什么是类，什么继承
new和malloc有什么区别
什么是虚函数，什么是虚继承
之类的泛泛而谈的入门问题
2 会C++
new实际上执行了什么操作，可能在什么步骤出现异常
怎么写一个class，禁止分配在栈上
怎么突破private的限制访问变量
虚继承的细节
怎么自己模拟实现引用
3 比较了解C++
主要是一些边角的语法或者是不常见的问题
逗号表达式，位域
初始化列表的异常怎么捕获
对于常见的主流编译器，写不写inline有什么影响
完美转发
怎么在编译器判断一个类中有没有定义某个特定的方法
构造函数中调析构函数会有什么结果



作者：Zenzen
链接：https://www.zhihu.com/question/20184857/answer/40666524
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


