---
title: Overload-Operator
date: 2017-12-13 18:45:26
categories: C/C++
tags:
---


```cpp
#include<iostream>
#include<vector>
using namespace std;

class test{
public:
     int v;
   /*构造函数*/
     test():v(0){}
     test(const int &a):v(a){}
     test(const test &t1):v(t1.v){} 
    
   /*以下重载小于号 < */
     //比较两个对象的大小 
     bool operator<(const test &t1) const{ 
         return (v < t1.v);
     }
     //比较对象和int的大小 
     bool operator<(const int &t1) const{ 
         return (v < t1);
     }
     //友元函数，比较int和对象的大小 
     friend inline bool operator<(const int &a, const test & t1){
         return (a < t1.v);
     }
    
   /*以下重载赋值号 = */
     //对象间赋值 
     //当函数返回引用类型时，没有复制返回值。相反，返回的是对象本身
     test & operator=(const test &t1){
         v = t1.v;
         return *this;
     }
     //int赋值给对象 
     test & operator=(const int &t1){
         v = t1;
         return *this;
     }
    
   /*以下重载加号 + */
     //对象加上 int 
     test operator+(const int & a){
         test t1;
         t1.v = v + a;
         return t1;
     }
     //对象加对象 
     test operator+(test &t1){
         test t2;
         t2.v = v + t1.v;
         return t2;
     }
    
   /*以下重载加等号 += */  
     //对象加上对象 
     test &operator+=(const test &t1){
         v += t1.v;
         return *this;
     }  
     //对象加上int
     test &operator+=(const int &a){
         v += a;
         return *this;
     }

   /*以下重载双等号 == */  
     //对象==对象
     //It is recommended practice to make as many functions const as possible so that accidental changes to objects are avoided 
     bool operator==(const test &t1)const{
         return (v == t1.v);
     }  
     //对象==int
     bool operator==(const int &t1)const{
         return (v == t1);
     }  
    
   /*以下重载 输入>> 输出<< */
     /*友元函数，输出对象*/
     friend inline ostream & operator << (ostream & os, test &t1){
         cout << "class t(" << t1.v << ")" << endl;
         return os;
     }
     /*友元函数，输入对象*/
     friend inline istream & operator >> (istream & is, test &t1){
         cin >> t1.v;
         return is;
     }
};

int main(){
     test t0, t1(3);
     test t2(t1);
     cout << t0 << t1 << t2;
     cin >> t1;
     t2 = t1;
     t2 += t1;
     t1 += 10;
     cout << t2;
     if(t1 < t2) cout << "t1 < t2"; 
     else if(t1 == t2) cout << "t1 = t2";
     else /* t1 > t2*/ cout << "t1 > t2"; 
     cout <<endl;
     system("pause");
     return 0;
}
```
