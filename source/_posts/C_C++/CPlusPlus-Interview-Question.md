---
title: CPlusPlus_Interview_Question
date: 2017-12-09 05:10:55
categories: C/C++
tags:
---

C++ 常见面试题。

1. C++ 在什么情况下没有构造函数
https://stackoverflow.com/questions/7131983/in-which-cases-there-is-no-constructor-at-all-even-a-default-constructor

2. Copy constructor vs assignment operator in C++


3. 多态的实现

4. 类型转换有哪些分类？

C++ 类型转换有隐式转换，和显示转换。 显示转换也称为强制转换。
static_cast C 类型的，没有类型检查的功能，不安全

dynamic_cast 只能将类的指针，引用，或者void * 转换成类的指针，引用，或者 void *, 具有类型检查的功能。比static_cast 更安全。 dynamic_cast 的基类要有虚函数，否则会编译出错。 static_cast 没有这个限制

const_cast 改变类型的const 或者volatile 属性。

reinterpret_cast 是为了映射到一个完全不同类型的意思.

5. C++ 的内存分配

6. 虚函数，纯虚函数，抽象类

1.构造函数：构造函数不能是虚函数 
2.析构函数：析构函数应当是虚函数 
3.友元：友元不能是虚函数 
因为友元不是类成员，而只有成员才能是虚函数。 
4.重定义，隐藏和覆盖

7. 指针和引用

一般建议使用引用参数，而不是指针参数.

8. 动态联编和静态联编

![](http://img.blog.csdn.net/20160412234138920)

静态联编实际就是函数重载和运算符重载， 它是编译过程汇总进行的联编
动态联编是程序运行过程中才动态的确定操作对象。

9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义9. C++ 左值 右值 在编程中有什么意义 

