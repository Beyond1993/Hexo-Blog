---
title: CMU-15640-1
date: 2017-08-20 08:03:01
categories: CMU课程
tags: cmu
---
# Project 1 Transparent-Remote-File-Operations
实现 cat filename 的远程调用，file 不在本机上.

## Configure
Ubuntu 16.04 

Makefile:
之前很奇怪 Makefile 为什么可以直接 all: client server,原来是相同目录下可以已经有了 client.c server.c  同名文件。
```basemake
PROGS=client server
CFLAGS+=-Wall
#add inlcude path
CFLAGS+=-I/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/include/
all: $(PROGS)

clean:
        rm -f *.o $(PROGS)
```
add the absolute path of libdirtree.so to LD_LIBRARY_PATH

http://www.cnblogs.com/benio/archive/2010/10/25/1860394.html
大写 -L 指定第三方库的目录
小写 -l 指定库文件，但要注意文件名，只是个链接，并不是真正的文件
大写 -I 指定头文件目录

这个也不行
gcc -Wall -I/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/include/ -L/home/wayne/Desktop/15440-Distributed-Systems/Transparent-Remote-File-Operations/lib/ -ldirtree   server.c   -o server

真是活见鬼了，在AWS上一次性编译成功，而且都没有设置 LD_LIBRARY_PATH. 看来本机的环境复杂，以后所有的实验都要放在instacne上跑了.

## 原理
![](/images/rpc.png)

[参考](http://www.cnblogs.com/codingexperience/p/5930752.html)

## 代码框架
```text
├── include
│   └── dirtree.h
├── interpose
│   ├── Makefile
│   └── mylib.c
├── lib
│   └── libdirtree.so
├── README
├── tcp-sample
│   ├── client
│   ├── client.c
│   ├── Makefile
│   ├── server
│   └── server.c
└── tools
    ├── 440cat
    ├── 440ls
    ├── 440read
    ├── 440rm
    ├── 440tree
    └── 440write
```
## client.c
```c
#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>
#include <err.h>

#define MAXMSGLEN 100

int main(int argc, char**argv) {
    char *serverip;
    char *serverport;
    unsigned short port;
    char *msg="Hello from client";
    char buf[MAXMSGLEN+1];
    int sockfd, rv;
    struct sockaddr_in srv;
    
    // Get environment variable indicating the ip address of the server
    serverip = getenv("server15440");
    if (serverip) printf("Got environment variable server15440: %s\n", serverip);
    else {
        printf("Environment variable server15440 not found.  Using 127.0.0.1\n");
        serverip = "127.0.0.1";
    }
    
    // Get environment variable indicating the port of the server
    serverport = getenv("serverport15440");
    if (serverport) fprintf(stderr, "Got environment variable serverport15440: %s\n", serverport);
    else {
        fprintf(stderr, "Environment variable serverport15440 not found.  Using 15440\n");
        serverport = "15440";
    }
    port = (unsigned short)atoi(serverport);
    
    // Create socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);    // TCP/IP socket
    if (sockfd<0) err(1, 0);            // in case of error
    
    // setup address structure to point to server
    memset(&srv, 0, sizeof(srv));            // clear it first
    srv.sin_family = AF_INET;            // IP family
    srv.sin_addr.s_addr = inet_addr(serverip);    // IP address of server
    srv.sin_port = htons(port);            // server port

    // actually connect to the server
    rv = connect(sockfd, (struct sockaddr*)&srv, sizeof(struct sockaddr));
    if (rv<0) err(1,0);
    
    // send message to server
    printf("client sending to server: %s\n", msg);
    send(sockfd, msg, strlen(msg), 0);    // send message; should check return value
    
    // get message back
    rv = recv(sockfd, buf, MAXMSGLEN, 0);    // get message
    if (rv<0) err(1,0);            // in case something went wrong
    buf[rv]=0;                // null terminate string to print
    printf("client got messge: %s\n", buf);
    
    // close socket
    close(sockfd);

    return 0;
}
```
server.c
```c
#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>
#include <err.h>

#define MAXMSGLEN 100

int main(int argc, char**argv) {
    char *msg="Hello from server";
    char buf[MAXMSGLEN+1];
    char *serverport;
    unsigned short port;
    int sockfd, sessfd, rv, i;
    struct sockaddr_in srv, cli;
    socklen_t sa_size;
    
    // Get environment variable indicating the port of the server
    serverport = getenv("serverport15440");
    if (serverport) port = (unsigned short)atoi(serverport);
    else port=15440;
    
    // Create socket
    sockfd = socket(AF_INET, SOCK_STREAM, 0);    // TCP/IP socket
    if (sockfd<0) err(1, 0);            // in case of error
    
    // setup address structure to indicate server port
    memset(&srv, 0, sizeof(srv));            // clear it first
    srv.sin_family = AF_INET;            // IP family
    srv.sin_addr.s_addr = htonl(INADDR_ANY);    // don't care IP address
    srv.sin_port = htons(port);            // server port

    // bind to our port
    rv = bind(sockfd, (struct sockaddr*)&srv, sizeof(struct sockaddr));
    if (rv<0) err(1,0);
    
    // start listening for connections
    rv = listen(sockfd, 5);
    if (rv<0) err(1,0);
    
    // main server loop, handle clients one at a time, quit after 10 clients
    for( i=0; i<10; i++ ) {
        
        // wait for next client, get session socket
        sa_size = sizeof(struct sockaddr_in);
        sessfd = accept(sockfd, (struct sockaddr *)&cli, &sa_size);
        if (sessfd<0) err(1,0);
        
        // get messages and send replies to this client, until it goes away
        while ( (rv=recv(sessfd, buf, MAXMSGLEN, 0)) > 0) {
            buf[rv]=0;        // null terminate string to print
            printf("server got messge: %s\n", buf);
            
            // send reply
            printf("server replying to client: %s\n", msg);
            send(sessfd, msg, strlen(msg), 0);    // should check return value
        }

        // either client closed connection, or error
        if (rv<0) err(1,0);
        close(sessfd);
    }
    
    printf("server shutting down cleanly\n");
    // close socket
    close(sockfd);

    return 0;
}

```
## Run
```shell
make
./server
./client
```
## Coding
我们主要要编写两个文件，server.c, mylib.c

mylib比标准库先链接到client里，mylib里是一些和标准库里名字一样的rpc函数 比如read，write，open，用来重载标准库函数。

client--call--&gt mylib.c --> send request --> server

## Analysis

## 小结
rpc的本质就是序列化与反序列化,其与restful API 这种远程调用不同之处，在于rpc传递的是序列化的对象，并且使得这个对象在远程执行，并返回结果
stub 的作用就是序列化，与反序列化
在hadoop 程序中广泛运用
