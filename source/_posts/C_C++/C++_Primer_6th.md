---
title: C++_Primer_6th
date: 2017-12-09 07:08:27
categories: C/C++
tags:
---
## 第一章 预备知识

oop提供了高级抽象
C提供了低级硬件访问

## 第二章  开始学习C++
让程序停住 cin.get()

若编译器到达main()函数末尾没有遇到返回语句，则认为main() 以 return 0 结尾 （隐含）

编译指令：using ，名称空间 namespace
解决不同厂商相同函数的冲突问题。
Microflop::wand("Go dancing");
Piscine::wand("A fish");

可以把Using namespace std;写到main函数里面，但在多函数程序中必须 把 Using 编译指令写到所有函数上面。
std 命名空间包含 类，函数，变量等所有C++标准组件
更恰当方法 using std::cout;
                 using std::cin;
                  using std::endl;

cout                    <<         "C++ RULES"  将一个字符串插入到输出流中
cout对象        插入运算符        字符串

声明语句和变量
int a;
a = 25;
将整数25赋值给a表示的内存单元

## 第三章 数据处理

头文件 climits 指出每种类型的最大值
char 是 比 short 更小的整型
const 常量限定符
浮点数
float 单精度 7位
double 双精度 16维，精度高 内存消耗大，速度慢

## 第四章 复合类型
字符串
1，C_style 字符串

'\0' 空字符至关重要

让数据比字符串长没什么坏处，只是浪费了空间,因为处理字符串的函数会根据空字符的位置，而不是数组长度来处理。
TIPS:在确定存储字符串所需的最短数组时，别忘了将结尾空字符计算在内。

字符串常量（双引号） 不能 与字符常量（单引号） 互换
char a ='S'; char 类型是整型，'S' 是83的另一种写法
char a = "S" 是不允许（将地址赋值给a） 因为"S"  表示字符S 和 \0. "S"实际上表示字符串所在内存地址

### 4.5 共用体
union 当数据使用两种或更多种格式（但不会同时使用），可节省空间。小商品目录 有些ID为整数，有些为字符串
union id
{
     long id_num;
     char id_char[20];
}

### 4.7 指针和自由存储空间
指针存储的值是地址，而非变量本身

面向对象编程 ：运行阶段决策，指针动态分配数组大小
和面向过程编程： 编译阶段决策 ，静态固定数组大小。

Applying the * operator, called the indirect value （间接值）or the dereferencing（解除引用） operator,yields the value at the location

int * p= new int;
delete p;

int * p= new int;
int * p = new short[10];
delete [ ] p;  释放数组

总之，使用new和delete时，应遵守以下规则。
不要使用delete来释放不是new分配的内存。
不要使用delete释放同一个内存块两次。
如果使用new [ ]为数组分配内存，则应使用delete [ ]来释放。
如果使用new [ ]为一个实体分配内存，则应使用delete（没有方括号）来释放。
对空指针应用delete是安全的。

现在从实际角度考虑这个问题。如何访问其中的元素呢？第一个元素不成问题。由于psome指向数组的第1个元素，因此*psome是第1个元素的值。这样，还有9个元素。如果没有使用过C语言，下面这种最简单的方法可能会令您大吃一惊：只要把指针当作数组名使用即可。也就是说，对于第1个元素，可以使用psome[0]，而不是*psome；对于第2个元素，可以使用psome[1]，依此类推。这样，使用指针来访问动态数组就非常简单了，虽然还不知道为何这种方法管用。可以这样做的原因是，C和C++内部都使用指针来处理数组。数组和指针基本等价是C和C++的优点之一（这在有时候也是个问题，但这是另一码事）。稍后将更详细地介绍这种等同性。首先，程序清单4.18演示了如何使用new来创建动态数组以及使用数组表示法来访问元素；它还指出了指针和真正的数组名之间的根本差别。

## 第5章 循环和关系表达式

## 第6章 分支语句和逻辑操作符

## 第7章 函数---C+的编程模块

## 第8章 函数探幽

## 第9章 内存模型和名称空间

## 第10章 对象和类

## 第11章 使用类

## 第12章 类的动态内存分配

## 第13章 Class Inheritance
public > protected > private;
class A{
    public: int a;
    protected : int b;
    private:  int c;
}

public: 任何环境都能访问
protected： 自己和继承类可以访问
private ： 只有自己能访问

继承：is-a 关系 通常不可逆

公有继承：继承父类 公有，保护 成员
保护继承：继承父类 公有，保护成员，将其变成保护
私有继承：继承父类 公有，保护成员，将其变成私有

公有继承最常见： is-a 。更准确的说是 is-a-kind-of , 不是is-like-a 不是 is-implemented-as-a,

多态公有继承：
 派生类对象使用基类方法。
实现多态公有继承两种方法：
--在派生类中重定义基类的方法t

多态：父类 指针/引用 指向子类对象。

Parent * p[3] ;
p[0] = new Parent();
p[1] =  new Children1();
p[2] = new Children2();

for(int i=0;i<3;i++){
     p[i]->foo();
}

静态联编（static binding) 早期编译 early binding
通过函数名，函数重载。 编译器就可以实现。

动态联编（dynamic binding） 晚期联编 late binding
编译时不能确定使用哪个函数，只能在运行时选择正确的虚方法。

new 是动态生成的, n是用户输入的
int * p = new int[n] ;

向上强制转化（upcasting)

通常，C++不允许将一种类型的地址赋给另一种类型的指针，也不允许一种类型的引用指向另一种类型

但在多态里：父类 指针/引用 指向子类对象。
Children kids();
Parent *p = &kid;
Parent &p = kid;

公有继承不需要进行显示类型转化。
这是is-a规则的一部分，Children 对象都是Parent对象，继承了Parent对象的所有数据成员和成员函数，所以对Parent对象的任何操作都适用于Children对象。

相反的向下强制转换则不能显示进行。
Parent p();
Children * kid = &p;//invalid

虚函数的工作原理：虚函数列表。

每个父类，子类里都有一个虚函数列表virtual function table（里面存储各个虚函数的地址）。都有一个隐藏的指针成员vtbl指向这个虚函数列表。

子类的函数列表肯定要包含父类的虚函数！！
![](/images/Polymorphism.png)

## 第14章 C++中的代码重用

## 第15章 友元，异常和其他

## 第16章 string 类和标准模版库

## 第17章 输入，输出和文件
