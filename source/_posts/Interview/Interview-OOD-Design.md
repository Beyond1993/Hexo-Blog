---
title: Interview-OOD-Design
date: 2017-09-26 20:26:48
categories: 面试
tags:
---
[UML](http://www.uml.org.cn/oobject/201510214.asp)
[关联_聚合_合成](https://www.infoworld.com/article/3029325/application-development/exploring-association-aggregation-and-composition-in-oop.html)

面向对象设计，考的是设计模式。

设计类的题目，理解需求永远是第一位的，要充分了解这个系统的的上下文环境

S.O.L.I.D 原则
* S - Single responsibility principle 一个类只负责一项工作
* O - Open close priciple 只拓展，不修改原有结构代码
* L - Liskov substitution principle 里氏替换原则 任何一个子类或派生类应该可以替换它们的基类或父类. 多态
* I - Interface segregation priciple 接口分离原则， 不应该强迫一个类实现它用不上的接口. 
* D - Dependaency inversion priciple 依赖反转原则，抽象不应该依赖于具体实现，具体实现应该依赖于抽象。 注意 Spring 里是控制反转.

1. 设计停车场，（实时教室座位统计系统）

第一节 面向对象设计入门 
OOA (Analysis), OOD (Design), OOP(Programming) 

5C-解题法
Clarify: 先确定上下文 
* What, 
* How, 
* Who, 
* When

Core Objects: 先想出一个最核心的，其他的再由此延伸:

Cases

Classes

Correctness

第二节 管理类面向对象设计

不要以为为主体设计系统，人的属性越少，系统越简单． 我们设计的是系统，而不是模拟游戏．　所以面试中减少人到的属性．

Management 类常见　use case
Reverve :
Serve:
Checkout:

设计停车场

设计餐馆

```text
       +--------------------------------+  +-------------------------+   +-------------------+
party  | Restaurant                     |  | Table                   |   | Order             |  Meal
       +--------------------------------+  +-------------------------+   +-------------------+
       |- List<Table> tables            |  | - Boolean avaliable     |   | - List<Meal> meals|
       |- List<Meal> menu               |  +-------------------------+
       |- Map<Table, List<Order>> orders|  | + Boolean isAvalibale() |   
       +--------------------------------+  | + void markUnavaliable()|
       |+ Table findTale()              |  | + void markAvaliable()  |
       +--------------------------------+  +-------------------------+


NoTableException                                         
```

用 markUnavailible(), bool 型变量，一定要意思明确

table 里加　order, 违反了　单一责任原则.

第三节 预定类面向对象设计

预定类比较难．和其他不同.更具体．

Use Case

- Search
- Select
- Cancel

重要公式:
*Search criteria -> Search() -> List&lt;Result&gt; -> Select() -> Receipt*

第四节 实物类面向对象设计 OOD for Real Life Object

[Vending Machine](http://javarevisited.blogspot.com/2016/06/design-vending-machine-in-java.html)

关键词: Vending Machiing coins items

大小是否有限制，

Input --> VendingMaching --> Output

keyword : Item. Payment

sold out

Coin/Paper money:知道当前收了多少钱，找零．
card: 不需要找零．

Map&lt;String,Item&gt; 更新不好处理  --> Map&lt;String, ItemInfo&gt; Enum

Vending Maching 的类是不希望改变的．

```text

```


静态Object, 动态Object

[Juke Box] 投币式自动播放点唱机


第五节 游戏棋牌类面向对象设计 



一．五种 创建型模式

１．单例模式Singleton



２．创造者模式 Builder



3. 工厂方法模式 Factory Method



4, 抽象工厂模式 Abstract Factory



5.原型模式 Prototype



二．七种 结构型模式

1.适配器模式 Adapter



2. 装饰器模式 Decorator



3.代理模式 Proxy



4.外观模式



5.桥模式 Bridge



6. 组合模式 Composite



7. 享元模式 Flyweight

    string pool



三.十一种行为模式

1.策略模式 stategy



2. 模板方法模式 Template Method



3. 观察者模式　Observer



4. 迭代模式 Iterator



5.责任链模式　Chain of Responsibility



6. 命令模式　Command 



7.备忘录模式　memento 



8. 状态模式　state



9.访问者模式 Visitor



10. 中介者模式 Mediator



11. 解释器模式 Interpreter








