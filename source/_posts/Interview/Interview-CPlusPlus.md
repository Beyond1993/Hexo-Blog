---
title: Interview-C++
date: 2017-11-01 05:43:42
categories:
tags:
---
```C++
#include <cstdio>
class Thing
{
private:
    int x;
    int y;
    virtual int foo()
    {
        return x+y;
    }

    virtual int bar()
    { 
        return x*y;
    }

public:
    Thing() {
        x = 2;
        y = 10;
    }
};

int extract_x(void *thing)
{

}

int extract_y(void *thing)
{

}

int call_foo(void *thing)
{

}
```

这一题只能在给定的函数里访问私有虚函数

Thing t;
int *addr = (int *) (&t);

用寻址的方法
