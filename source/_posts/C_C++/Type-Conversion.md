---
title: Type Conversion
date: 2018-05-05 03:25:31
categories: C/C++
tags:
---


## 1.char array ---> const char
直接赋值即可

char* pc = "abc";

const char* cpc = pc;

## 2.char  --->  string


直接赋值即可



char* pc = "abc";

const char* cpc = pc;

string s(cpc);

## 3.const char * ---->  char *
指向const的指针不能被赋给指.向非const的指针,所以应该用strcpy，也就是另开一块内存，把字符一个个复制过去
const char *expr = "goodidea";
char *buf = new char[strlen(expr)+1];
strcpy(buf, expr);

## 4. const char ---> string
直接赋值即可

const char* c_s = "abc";

string s(c_s);


## 5. string -----> char array
string s = "abc";
const char *str = s.c_str();
char *buf = new char[strlen(str)+1];// '\0'
strcpy(buf, str);

## 6. string ---> const char
string s = "abc";
const char *str = s.c_str();




