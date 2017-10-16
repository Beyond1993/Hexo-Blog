---
title: Thrift
date: 2017-10-16 07:04:23
categories: BigData
tags:
---
1.下载源代码

http://mirror.reverse.net/pub/apache/thrift/0.10.0/thrift-0.10.0.tar.gz

下载最新版本 thrift-0.10.0.tar.gz



2.安装boost库

sudo apt-get install libboost-dev 

sudo apt-get install  libboost-dbg 

sudo apt-get install  libboost-doc 

sudo apt-get install bcp ？？？

sudo apt-get install libboost-*



3.安装其他相关工具包

sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev ant

如果需要支持java，需要安装jdk，配置java环境变量。



4.解压文件，进入目录thrift-0.10.0安装

./configure --with-cpp --with-boost --without-python --without-csharp --with-java --without-erlang --without-perl --with-php --without-php_extension --without-ruby --without-haskell  --without-go

make

sudo make install

要支持java，需要编译生成jar包，到lib/java目录下，执行 ant命令。将在lib/java/build目录下生成libthrift-0.8.0.jar和libthrift-0.8.0-javadoc.jar。编译过程中，可能出错，需要检查lib/java/build/tools/maven-ant-tasks-2.1.3.jar是否正确下载。



$vim ~/.bashrcexport LD_LIBRARY_PATH=/usr/local/lib/:${LD_LIBRARY_PATH}$source ~/.bashrc
$echo $LD_LIBRARY_PATH
$thrift -version
 or

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/




5.测试

直接输入thrift命令，看是否有用法提示 

二、thrift自带的测试样例

进入tutorial文件夹，shared.thrift和tutorial.thrift是接口定义文件。

thrift -r --gen java tutorial.thrift

thirft -r --gen cpp tutorial.thrift

执行这两条命令可以生成gen-java和gen-cpp两个文件夹，这些是thrift编译器自动生成的代码。

然后到java目录下，执行 ant命令，编译成功后，在两个不同的窗口下执行以下命令：

./JavaServer

./JavaClient simple




Service is like an Interface in Java or pure virtual function.

An interface can inherit another interface to add more method, that means service in Thrift can also inherit another service.

