---
title: Java-Interview-Questions
date: 2017-12-30 20:19:03
categories: Java
tags:
---


### 1. 抽象类与接口
只要类里有一个抽象方法（没有实现) ，就是抽象类，但接口里的方法全部不能实现。

**什么时候使用抽象类**
如果你拥有一些方法并且想让它们中的一些有默认实现，那么使用抽象类吧。
如果基本功能在不断改变，那么就需要使用抽象类。因为如果不断改变基本功能并且使用接口，那么就需要改变所有实现了该接口的类。

**什么时候使用接口?**
如果你想实现多重继承，那么你必须使用接口。由于Java不支持多继承，子类不能够继承多个类，但可以实现多个接口。因此你就可以使用接口来解决它。

### 2. final, finally, finalize 的区别
final 用于声明属性，方法和类，分别表示属性不可变，方法不可覆盖，类不可继承。

**内部类要访问局部变量，局部变量必须定义成final 类型?**

finally 是异常处理语句的一部分，表示总是执行。

finalize 是 Object 类的一个方法，在垃圾收集器执行的时候会调用被回收对象的此方法，可以覆盖此方法提供垃圾收集时的其他资源回收， 例如关闭文件。 **JVM 不保证此方法总被调用**

### 3. Runtime Exception VS Exception VS Error
http://www.geeksforgeeks.org/checked-vs-unchecked-exceptions-in-java/

checked 是在编译时就check的，必须要 declaration.

uncheck 在编译时不检查，不必须 declaration. 除了 Error和 RuntimeException 其他都是checked.

```text
                   +-----------+
                   | Throwable |
                   +-----------+
                    /         \
                   /           \
          +-------+          +-----------+
          | Error |          | Exception |
          +-------+          +-----------+
           /  |   \          /  |   \      \
          \________/         \______/       \
           unchecked          checked   +------------------+
                                        | RuntimeException |
                                        +------------------+
                                         /     |    |      \
                                         \_________________/
                                              unchecked



```

这里我们就需要理解， 为什么Error, 和继承自 Exception 的 RuntimeException 是unchecked。

因为error 和 RuntimeException 都是不可控制的。

Uually, a RuntimeException indicates a programming error (in which case you can't "handle" it, because if you knew to expect it you'd have avoided the error).

所以 catch a RuntimeException is not a good practice

// must throw
public class FactorialException extends Exception {
…
}
//don't have to throw
public class FactorialException extends RuntimeException {
…
}

### 4. 常见的Runtime Exception
NullPointerException - 空指针引用异常
ClassCastException - 类型强制转换异常。
IllegalArgumentException - 传递非法参数异常。
ArithmeticException - 算术运算异常
ArrayStoreException - 向数组中存放与声明类型不兼容对象异常
IndexOutOfBoundsException - 下标越界异常
NegativeArraySizeException - 创建一个大小为负数的数组错误异常
NumberFormatException - 数字格式异常
SecurityException - 安全异常
UnsupportedOperationException - 不支持的操作异常
  
### 5. Nested class VS inner class
```java
                  + static ---> static nested classes
Nested Classes ---+ 
                  + non-static ---> inner classes
```
