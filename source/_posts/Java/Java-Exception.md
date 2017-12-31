---
title: Java-Exception
date: 2017-10-16 06:57:45
categories: Java
tags:
---

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


```java
public long Factorial (int n) throws FactorialException {
 int sign = 1;
 if (n < 0) {
  throw new FactorialException(“the number is negtive!”);
 }
 long result  = 1;
 for (int i = n; i >=1 ; i--) {
   Result *= i;
  }
  Return result * sign;
}

// must throw
public class FactorialException extends Exception {
…
}
//don't have to throw
public class FactorialException extends RuntimeException {
…
}
```


