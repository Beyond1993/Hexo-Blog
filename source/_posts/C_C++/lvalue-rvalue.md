---
title: 左值引用 VS 右值引用
date: 2017-12-11 20:58:35
categories: C/C++
tags:
---

https://eli.thegreenplace.net/2011/12/15/understanding-lvalues-and-rvalues-in-c-and-c

http://bbs.itheima.com/thread-229524-1-1.html
C++ 11 中所有的值必属于 左值 右值。
左值： 左值可以取变量的地址，有名字
右值： 右值变量存储的内容，不能取地址, 没有名字（分为将亡值和纯右值）

int a = b + c

a is left value with variable name a, the address can be accessed by &a. 

the expression (b+c) or the return value of int func() are right value. 

we can not find them before assign them to another variable and &(b+c) can not compile 

## 左值引用 右值引用

左值引用就是对一个左值进行引用的类型。

左值引用 是为了解决 指针应用不规范引入的。

对于 
int func(Object * obj) {

}

指针应用很不安全，尤其指针本身可以加减运算.  obj + 1, obj + 2

可以把左值引用理解成弱版的指针。

int func(Object & obj) {
  
}

这样传递就安全的多。


右值引用 是一场技术的革新。
https://www.zhihu.com/question/22111546

右值引用就是对一个右值进行引用的类型，事实上，由于右值通常不具有名字，我们也只能通过引用的方式找到它的存在。

右值引用和左值引用都是属于引用类型。无论是声明一个左值引用还是右值引用，都必须立即进行初始化。而其原因可以理解为是引用类型本身自己并不拥有所绑定对象的内存，只是该对象的一个别名。左值引用是具名变量值的别名，而右值引用则是不具名（匿名）变量的别名。

左值引用通常也不能绑定到右值，但常量左值引用是个“万能”的引用类型。它可以接受非常量左值、常量左值、右值对其进行初始化。不过常量左值所引用的右值在它的“余生”中只能是只读的。相对地，非常量左值只能接受非常量左值对其进行初始化。

int &a = 2;       # 左值引用绑定到右值，编译失败

int b = 2;        # 非常量左值
const int &c = b; # 常量左值引用绑定到非常量左值，编译通过
const int d = 2;  # 常量左值
const int &e = c; # 常量左值引用绑定到常量左值，编译通过
const int &b =2;  # 常量左值引用绑定到右值，编程通过

右值值引用通常不能绑定到任何的左值，要想绑定一个左值到右值引用，通常需要std::move()将左值强制转换为右值，例如：

int a;
int &&r1 = c;             # 编译失败
int &&r2 = std::move(a);  # 编译通过
