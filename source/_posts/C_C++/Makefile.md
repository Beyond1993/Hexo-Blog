---
title: Makefile
date: 2017-08-20 08:34:24
categories: C/C++
tags:
---
Makefile里有很多依赖关系，程序流程，只讲最精简的部分

```makefile
##############################################
#
# 单目录通用Makefile
# 目标文件可自己的设定
# 始须调试程序，修改 CFLAGS 变量为-Wall -g
#
# wuyq 20140825
##############################################
  
# EXECUTABLE为目标的可执行文件名, 可以根据具体的情况对其进行修改。
EXECUTABLE := spi
  
# 修改隐含规则中宏
CC := arm-linux-gcc
CFLAGS := -Wall -O2
LDFLAGS+= -static
#LDFLAGS+= -lftd2xx 
  
# 列出工作目录下所有以“.c”结尾的文件，以空格分隔，将文件列表赋给变量SOURCE
SOURCE := $(wildcard *.c)
  
# 调用patsubst函数，生成与源文件对应的“.o”文件列表
OBJS := $(patsubst %.c, %.o, $(SOURCE))
  
# 编译所有".o"文件生成可执行文件
all : $(EXECUTABLE)
$(EXECUTABLE) : $(OBJS)
    @$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(EXECUTABLE)
  
# 声明伪目标
.PHONY : clean
  
# 删除所有中间文件和目标文件
clean :
    @rm -f $(EXECUTABLE) $(OBJS) *.o

```
每一行的，冒号之前。

a : b
b : c
c : main.cpp

是一条编译链：
例如： make a, 则执行顺序是 main.c -> c -> b -> a 


```makefile
PROGS=client server
CFLAGS+=-Wall

all: $(PROGS)


clean:
        rm -f *.o $(PROGS)
```

比较奇葩的



${MODS:%=%.beam} 是Makefile 变量替换的一种方式.
其格式是 $(var:%.c=%.o)或${var:.c=.o},其意思是把.c 为结尾的变量替换成.o
% 则代表任意匹配之外的字符串.

实例1:
source: main.c onvif.c

object: $(var:%.c=%.o)

这个时候 %分别等于 main 与 onvif
而 object 则等于 main.o 与 onvif.o

实例2: 
${MODS:%=%.beam}
第一个%没有带任何过滤条件.%则表示任意字符串.
第二个%表示在字符串后面添加一个 .beam
${MODS:%=%.beam} 的意思是把为变量添加一个 .beam 后缀
