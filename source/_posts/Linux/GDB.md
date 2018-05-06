---
title: GDB
date: 2018-05-06 02:19:07
categories: LeetCode
tags:
---

## 用GDB调试程序

用GDB调试程序（一）

用GDB调试程序
GDB概述
————
GDB是GNU开源组织发布的一个强大的UNIX下的程序调试工具。或许，各位比较喜欢那种图形界面方式的，像VC、BCB等IDE的调试，但如果你是在UNIX平台下做软件，你会发现GDB这个调试工具有比VC、BCB的图形化调试器更强大的功能。所谓“寸有所长，尺有所短”就是这个道理。
一般来说，GDB主要帮忙你完成下面四个方面的功能：
    1、启动你的程序，可以按照你的自定义的要求随心所欲的运行程序。
    2、可让被调试的程序在你所指定的调置的断点处停住。（断点可以是条件表达式）
    3、当程序被停住时，可以检查此时你的程序中所发生的事。
    4、动态的改变你程序的执行环境。
从上面看来，GDB和一般的调试工具没有什么两样，基本上也是完成这些功能，不过在细节上，你会发现GDB这个调试工具的强大，大家可能比较习惯了图形化的调试工具，但有时候，命令行的调试工具却有着图形化工具所不能完成的功能。让我们一一看来。
一个调试示例
——————
源程序：test.c
      #include <stdio.h>
     
      int func(int n)
      {
              int sum=0,i;
              for(i=0; i<n; i++)
              {
                      sum+=i;
              }
             return sum;
     }
    
    
     int main()
     {
             int i;
             long result = 0;
             for(i=1; i<=100; i++)
             {
                     result += i;
             }
    
            printf("result[1-100] = %ld \n", result );
            printf("result[1-250] = %ld \n", func(250) );
              return 0;
     }
编译生成执行文件：（Linux下）
    $ gcc -g test.c -o test
使用GDB调试：
$ gdb test  <---------- 启动GDB
查看源码
(gdb) l     <-------------------- l命令相当于list，从第一行开始例出原码。
1        #include <stdio.h>
2
3        int func(int n)
4        {
5                int sum=0,i;
6                for(i=0; i<n; i++)
7                {
8                        sum+=i;
9                }
10               return sum;
(gdb)       <-------------------- 直接回车表示，重复上一次命令
11       }
12
13
14       main()
15       {
16               int i;
17               long result = 0;
18               for(i=1; i<=100; i++)
19               {
20                       result += i;   

设置断点：
(gdb) break 16    <-------------------- 设置断点，在源程序第16行处。
Breakpoint 1 at 0x8048496: file test.c, line 16.
(gdb) break func  <-------------------- 设置断点，在函数func()入口处。
Breakpoint 2 at 0x8048456: file tst.c, line 5.
(gdb) info break  <-------------------- 查看断点信息。
Num Type           Disp Enb Address    What
1   breakpoint     keep y   0x08048496 in main at tst.c:16
2   breakpoint     keep y   0x08048456 in func at tst.c:5

运行：
(gdb) r           <--------------------- 运行程序，run命令简写
Starting program: /home/wanye/Desktop/learngdb/test
Breakpoint 1, main () at test.c:17    <---------- 在断点处停住。
17               long result = 0;
下一步
(gdb) n          <--------------------- 单条语句执行，next命令简写。
18               for(i=1; i<=100; i++)
跳出循环 continue
(gdb) c          <--------------------- 继续运行程序，continue命令简写。
Continuing.
result[1-100] = 5050       <----------程序输出。

输出变量
(gdb) p i        <--------------------- 打印变量i的值，print命令简写。
$1 = 134513808

查看函数堆栈
(gdb) bt        <--------------------- 查看函数堆栈。
#0  func (n=250) at tst.c:5
#1  0x080484e4 in main () at tst.c:24
#2  0x400409ed in __libc_start_main () from /lib/libc.so.6

退出函数
(gdb) finish    <--------------------- 退出函数
Run till exit from #0  func (n=250) at tst.c:5
0x080484e4 in main () at tst.c:24
24              printf("result[1-250] = %d /n", func(250) );
Value returned is $6 = 31375
(gdb) c     <--------------------- 继续运行。
Continuing.
result[1-250] = 31375    <----------程序输出。
Program exited with code 027. <--------程序退出，调试结束。
(gdb) q     <--------------------- 退出gdb。
hchen/test>
好了，有了以上的感性认识，还是让我们来系统地认识一下gdb吧。
使用GDB
————
一般来说GDB主要调试的是C/C++的程序。要调试C/C++的程序，首先在编译时，我们必须要把调试信息加到可执行文件中。使用编译器（cc/gcc/g++）的 -g 参数可以做到这一点。如：
    > cc -g hello.c -o hello
    > g++ -g hello.cpp -o hello
如果没有-g，你将看不见程序的函数名、变量名，所代替的全是运行时的内存地址。当你用-g把调试信息加入之后，并成功编译目标代码以后，让我们来看看如何用gdb来调试他。
启动GDB的方法有以下几种：
    1、gdb <program> 
       program也就是你的执行文件，一般在当然目录下。
    2、gdb <program> core
       用gdb同时调试一个运行程序和core文件，core是程序非法执行后core dump后产生的文件。
    3、gdb <program> <PID>
       如果你的程序是一个服务程序，那么你可以指定这个服务程序运行时的进程ID。gdb会自动attach上去，并调试他。program应该在PATH环境变量中搜索得到。
GDB启动时，可以加上一些GDB的启动开关，详细的开关可以用gdb -help查看。我在下面只例举一些比较常用的参数：
    -symbols <file> 
    -s <file> 
    从指定文件中读取符号表。
    -se file 
    从指定文件中读取符号表信息，并把他用在可执行文件中。
    -core <file>
    -c <file> 
    调试时core dump的core文件。
    -directory <directory>
    -d <directory>
    加入一个源文件的搜索路径。默认搜索路径是环境变量中PATH所定义的路径。


从一个断点到另一个断点 c 

bt程序堆栈  可以追踪运行时函数调用

## GDB 命令行参数调试
进入gdb调试：

      gcc -g -Wall httpTest.c -o test    生成了可调试文件

      gdb test                                        进入调试

      下面可以使用两种方法输入命令行参数

      1）run  命令行参数

      2）set args  命令行参数

     如：我的程序中需要输入的时服务器端ip地址，可以通过以下两种方法输入

     1）如果直接运行程序，run  www.baidu.com

     2)set  args www.baidu.com,后面再继续进行调试

     查了好些资料，最后还是发现挺简单的，记下来供以后用    


## GDB 调试多文件
文件一： main.cpp
#include "mytool1.h"
#include "mytool2.h"
#include "stdio.h"

int main(int argc, char **argv) {
mytool1_print("hello");
mytool2_print("hello,husince");
}

文件二： mytool1.cpp
#include "mytool1.h"
#include "stdio.h"

void mytool1_print(char *print_str){
printf("This is mytool1 print %s\n",print_str);
}

文件三：mytool1.h
#ifndef _MYTOOL_1_H
#define _MYTOOL_1_H

void mytool1_print(char *print_str);

#endif

文件四：mytool2.cpp
#include "mytool2.h"
#include "stdio.h"

void mytool2_print(char *print_str){
printf("This is mytool2 print %s\n", print_str);
}

文件五：mytool2.h
#ifndef _MYTOOL_2_H
#define _MYTOOL_2_H

void mytool2_print(char *print_str);

#endif

以上是源文件， 还写了个makefile:
exe : main.o mytool1.o mytool2.o
     g++ -g -o exe $^  -----------------------------------------这一行不能顶格写！！！要tab
main.o : main.cpp mytool1.h mytool2.h
     g++ -g -c main.cpp
mytoo11.o : mytool1.cpp mytool1.h
     g++ -g -c mytool1.cpp
mytool2.o : mytool2.cpp mytool2.h
     g++ -g -c mytool2.cpp
clean :
     rm exe main.o mytool1.o mytool2.o

1.$ gdb exe  ---------------------------------进入gdb
2.(gdb) b main.cpp:6       -------------------main 的第6行
3.(gdb) b mytool1.cpp:mytool1_print   --------mytool1.cpp 的 mytool1_print()函数

## GDB 查看数组 指针

#include<stdio.h>
#include<stdlib.h>

int main(){
    int a[5] = {1,2,3,4,5};
    int *p = a;
    printf("debug array and point \n");
    return 0;
}

最主要的是 *p@5
(gdb) n
7 printf("debug array and point \n");

(gdb) p a
$1 = {1, 2, 3, 4, 5}
(gdb) p p
$2 = (int *) 0x7fffffffddf0
(gdb) p *p
$3 = 1
(gdb) p p[2]
$4 = 3
(gdb) p *p@5
$5 = {1, 2, 3, 4, 5}
(gdb) p *p@6
$6 = {1, 2, 3, 4, 5, 32767}
(gdb) 


