---
title: Copy-Constructor
date: 2017-12-13 19:04:55
categories: C/C++
tags:
---

拷贝构造函数就是一个成员函数，用另一个类来初始化这个类

prototype:
ClassName (const ClassName &old_obj)

```cpp
#include<iostream>
using namespace std;

class Point
{
  private:
     int x, y;
  public:
     Point (int x1, int y1) { x = x1; y = y1;}

     //Copy constructor
     Point (const Point &p2) { x = p2.x; y = p2.y}
  
     int getX() { return x;}
     int getY() { return y;}
};

int main()
{
    Point p1(10, 15); // Normal constructor is called here
    Point p2 = p1; // Copy constructor is called here
 
    // Let us access values assigned by constructors
    cout << "p1.x = " << p1.getX() << ", p1.y = " << p1.getY();
    cout << "\np2.x = " << p2.getX() << ", p2.y = " << p2.getY();
 
    return 0;
}

```
output

```text
p1.x = 10, p1.y = 15
p2.x = 10, p2.y = 15 
```


这时候我们应该理解为什么，在重载运算符的时候，要返回一个引用了，这样就可以不掉用copy

constructor了
```cpp
#include<iostream>
#include<stdio.h>
 
using namespace std;
 
class Test
{
public:
   Test() {}
   Test(const Test &t)
   {
      cout<<"Copy constructor called "<<endl;
   }
   Test& operator = (const Test &t)
   {
      cout<<"Assignment operator called "<<endl;
   }
};
 
int main()
{
  Test t1, t2;
  t2 = t1;
  Test t3 = t1;
  getchar();
  return 0;
}
```

output 
```text
t2 = t1;  // calls assignment operator, same as "t2.operator=(t1);"
Test t3 = t1;  // calls copy constructor, same as "Test t3(t1);"
```
