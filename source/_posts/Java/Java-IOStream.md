---
title: Java-IOStream
date: 2017-10-16 05:36:44
categories: Java
tags:
---


选自 《java 核心技术 》 高级 第九版

第一章 流和文件

输入流：读一串字节（a sequence of bytes）

输出流：写一串字节

这种字节串 一般是文件，但也可能是 网络链接甚至是一块内存。

InputStream 和 OutputStream 类 继承于 input/output（I/O）类。

这种流在处理Unicode编码时并不高效，因为Unicode 是一个字符有多个字节（multiple bytes per character），所以可以用Reader 和 Writer类来处理，这是基于两字节Unicode编码的。  

什么是流？





ps: java io 体系所有子类的名称的后缀名一般都是父类的名称。
 
InputStream 是所有字节输入流的超类，它是个抽象类。并且所有过滤流的构造函数接收的类型也是它。 
其中的方法也是所有输入流类都有的方法：
available() 返回当前未读的字节数，
close() 关闭流资源，
mark(int readlimit) 标记当前输入流所在的位置，也就是当前输入流读取到的位置，readlimit 表示最大缓存多少个字节，也就是记忆多少个字节。当调用reset()方法的时候会重新定位到mark方法定位时的位置。InputStream 里没有实现这两个方法，只会抛出IOException。
markSupported() 测试此输入流是否支持 mark 和 reset 方法。
read()方法，读取单个字节，以int类型返回，是个抽象方法。
read(byte[]) 从输入流中读取一定数量的字节，并将其存放到字符数组中。
read(byte[] b,int startIndex,int len) 从输入流中的startIndex位置读取len个字节放到字符数组中,
reset()方法，将此流重新定位到最后一次对此输入流调用 mark 方法时的位置。
skip(long n)方法， 跳过和丢弃此输入流中数据的 n 个字节。


OutputStream:

java.io.OutputStream 1.0
• abstract void write(int n)
writes a byte of data.
• void write(byte[] b)
• void write(byte[] b, int off, int len)
writes all bytes or a range of bytes in the array b.
• void close()
flushes and closes the output stream.
• void flush()
flushes the output stream—that is, sends any buffered data to its destination.



java IO 是个很大家族。可以根据自己不同的输入输出需要选择不同的流。



很多情况下，文件是以二进制存放的，因为效率更高。

但我们打开二进制文件时，却常常显示16进制，因为如果以二进制表示篇幅太大，也不利于阅读，同时十六进制可以方便的转成二进制。

不同的编码体系转成二进制文件也不同。例如string “1234”

UTF-16 : 00 31 00 32 00 33 00 34 

ISO 8859-1 : 31 32 33 34 (没有0字节)



Java IO 是典型的装饰者模式，通过在原来的流上加装饰，功能不断增强。



• To write data in binary format, you use a DataOutputStream.
• To write in text format, you use a PrintWriter.

只介绍两个典型的用法

1.读取写入txt文件

读取：

Scanner 

写入：

这两句是等效的

PrintWriter out = new PrintWriter("employee.txt");
PrintWriter out = new PrintWriter(new FileWriter("employee.txt"));

当定义了out对象，就可一System.out里最常见的print, println, 和 printf 方法去写文件了！

import java.io.PrintWriter;

void writeFile(){


        try{

        PrintWriter out = new PrintWriter("test.txt");

        out.print("sd");

        out.println();

        out.print("as");

        out.close(); //不加的话，就是只写到buffer里，一定要加

    }catch(Exception e){

        System.out.println(e.getMessage());

    }

       



}



2.标准输入输出流


