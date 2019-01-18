---
title: Effective Modern C++
date: 2018-04-28 17:45:12
categories: C/C++
tags:
---

# 42 Specific Ways to Improve Your Use of C++11 and C++14 

## 第一章 类型推导
条款1：理解模板类型推导
条款2：理解auto类型推导
条款3：理解decltype
条款4：知道如何查看类型推导

## 第二章 auto关键字
条款5：优先使用auto而非显式类型声明
条款6：当auto推导出非预期类型时应当使用显式的类型初始化

## 第三章 使用现代C++
条款7：创建对象时区分()和{}
条款8：优先使用nullptr而不是0或者NULL
条款9：优先使用声明别名而不是typedef
条款10：优先使用作用域限制的enmu而不是无作用域的enum
条款11：优先使用delete关键字删除函数而不是private却又不实现的函数
条款12：使用override关键字声明覆盖的函数
条款13：优先使用const_iterator而不是iterator
条款14：使用noexcept修饰不想抛出异常的函数
条款15：尽可能的使用constexpr
条款16：保证const成员函数线程安全
条款17：理解特殊成员函数的生成

## 第四章 智能指针
Raw Pointer 的问题

1. 不能确定是否指向single object  or an array

2. 这个指针在结束的时候，并不清楚什么需不需要销毁他所指向的内容.

3. 当我们决定要销毁指针指向的内容的时候，并不知道怎么去做.

4. 问题1导致了我们并不知道 是 delete a single object or array

5. 就算知道指针指向的内容，而且知道怎么去销毁，也很难一次性销毁干净。missing a path leads to resource leaks, 多于一次 会导致 undefined behavior.

6. 不知道是否是野指针


std::unique_ptr are same size, same instructions, small and fast enough, as raw pointers

std::unique_ptr is thus a move-only type, can not be copied.

Raw Pointer 的缺点：
·从声明看不出它是指向一个单个的对象还是一个数组
·当你使用完它的时候，从它的声明看不出你是否应该把它销毁，例如，当指针拥有它当前指向的对象时？不太懂
·
·
·
·
C++11 标准中规定了四个智能指针: std::auto_ptr, std::unique_ptr, std::shared_ptr, 以及 std::weak_ptr。它们都是用来设计辅助管理动态分配对象的生命周期，确保这些对象在h正确的时间（包括发生异常时）用正确的方式进行回报，以确保不会产生内存泄漏。

std::unique_ptr 做到了 std::auto_ptr 所能做到的所有事，而且更高效。
条款18：使用std::unique_ptr管理独占资源
条款19：使用std::shared_ptr管理共享资源
条款20：在std::shared_ptr类似指针可以悬挂时使用std::weak_ptr
条款21：优先使用std::make_unique和std::make_shared而不是直接使用new
条款22：当使用Pimpl的时候在实现文件中定义特殊的成员函数

## 第五章 右值引用、移动语义和完美转发
条款23：理解std::move和std::forward
条款24：区分通用引用和右值引用
条款25：在右值引用上使用std::move 在通用引用上使用std::forward
条款26：避免在通用引用上重定义函数
条款27：熟悉通用引用上重定义函数的其他选择
条款28：理解引用折叠
条款29：假定移动操作不存在，不廉价，不使用
条款30：熟悉完美转发和失败的情况

## 第六章 Lambda表达式
条款31：避免默认的参数捕捉
条款32：使用init捕捉来移动对象到闭包
条款33：在auto&&参数上使用decltype当std::forward auto&&参数
条款34：优先使用lambda而不是std::bind

##第七章 并发API
条款35：优先使用task-based而不是thread-based
条款36：当异步是必要的时声明std::launch::async
条款37：使得std::thread在所有的路径下无法join
条款38：注意线程句柄析构的行为
条款39：考虑在一次性事件通信上void的特性
条款40：在并发时使用std::atomic 在特殊内存上使用volatile

## 第八章 改进
条款41：考虑对拷贝参数按值传递移动廉价，那就尽量拷贝
条款42：考虑使用emplace代替insert

1. Deducing Types

2. auto

3. Moving to Modern C++

4. Smart Pointers

5. Rvalue References, Move Semantics, and Perfect Forwarding

6. Lambda Expressions

7. The Concurrency API

8. Tweaks (调校)
