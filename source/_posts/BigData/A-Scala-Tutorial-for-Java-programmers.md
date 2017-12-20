---
title: A Scala Tutorial for Java progrmmers
date: 2017-12-19 21:22:14
categories: Algorithm
tags:
---

## 1. 介绍 -- Introduction

## 2. 第一个例子 -- A first example

```scala
object HelloWorld {
  def main(args: Array[String])
  {
      println("Hello, world!");
  }
}
```

对于包含main 方法的object 声明，是scala特有的，这种声明方式引入了一个singleton object

在定义一个类的同时，还声明了该类的一个实例，实例名也是 HelloWorld。该实例在声明时即被创建。

在main 方法中并没有声明 static, Scala 不存在静态成员，而是用singleton objects 代替静态成员

## 2.1 编译该示例 
scalac 编译器生成的目标文件是标准的java class 文件。

## 2.2 运行该示例 
scala 命令行和java 非常像

## 3 和 java 进行交互
Scala 最强的是和java 进行交互，java.lang包是默认引进的，其他的包则需要explicitly 引入.

scala 引入java 包比 java 强大 ，
要想引入一个包中的多个类，在 Scala 中可以写在一行上，只需要把多个类名放到
一个大括号中(curly braces, {})即可
唯一要注意的是，当引入全部class 的时候，scala 是用的下划线

import java.text.DateFormat._

因为scala 中 * 是一个合法的标识符

```scala
import java.util.{Date, Locale}
import java.text.DateFormat
import java.text.DateFormat._
object FrenchDate {
  def main(args: Array[String]) {
    val now = new Date
    val df = getDateInstance(LONG, Locale.FRANCE)
    println(df format now)
  }
}
```

可以看到 scala 中的 **df format now** 其实是个infix 语法， 等价于 df.format(now)

Scala 中可以直接继承java的类或者实现Java 的接口。

## 4 一切皆对象
Scala 中的一切都是对象，是pure-object-oriented 语言，
java 中并不能将primitive types 和 function 当作object

一切即对象的思想内核就是 所有的东西都有自己的方法，成员变量

### 4.1 数字是对象

### 4.2 函数是对象
在scala中，function is a objetc, 函数可以当作参数进行传递，可以把函数存储在变量中，也可以把函数作为其他函数的返回值。这种将函数当做值进行操作的能力，是函数式编程的基石之一。

其实函数式编程，就是不断的搞闭包调用，早在javascript 里早就玩烂了.

## 5 类 
### 5.1 无参方法
### 5.2 继承和方法重写

6 条件类和模式匹配

7 Traits
在 Scala中Trait 为重用代码的一个基本单位。一个 Traits 封装了方法和变量，和 Interface 相比，它的方法可以有实现，这一点有点和抽象类定义类似。但和类继承不同的是，Scala 中类继承为单一继承，也就是说子类只能有一个父类。当一个类可以和多个 Trait 混合，这些 Trait 定义的成员变量和方法也就变成了该类的成员变量和方法，由此可以看出 Trait 集合了 Interface 和抽象类的优点，同时又没有破坏单一继承的原则。


