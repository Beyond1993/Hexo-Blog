---
title: CMU-15640-4-Scalable-Service
date: 2017-08-20 08:03:01
categories: CMU课程
tags: cmu
---
# Project 4 Scalable Service
resilint service 弹性服务。
实现 Paxos 算法。

service fail: 可能由于硬件，软件，人为，环境因素
需求增加：某个高峰期，需求增大

Resiliency 三个步骤：
1. 检测错误 
2. 清理现场
3. 启动恢复

闲言碎语不要讲，先看代码目录结构
```shell
.
├── README
├── doc
│   ├── NodeLauncher.html
│   ├── Project4.Messaging.html
│   ├── Project4.RemoteControllable.html
│   ├── Project4.html
│   ├── ProjectLib.CommitServing.html
│   ├── ProjectLib.Message.html
│   ├── ProjectLib.MessageHandling.html
│   ├── ProjectLib.html
│   ├── allclasses-frame.html
│   ├── allclasses-noframe.html
│   ├── constant-values.html
│   ├── deprecated-list.html
│   ├── help-doc.html
│   ├── index-all.html
│   ├── index.html
│   ├── overview-tree.html
│   ├── package-frame.html
│   ├── package-summary.html
│   ├── package-tree.html
│   ├── script.js
│   ├── serialized-form.html
│   └── stylesheet.css
├── lib
│   ├── NodeLauncher.class
│   ├── Project4$Controller$1.class
│   ├── Project4$Controller$Node.class
│   ├── Project4$Controller.class
│   ├── Project4$Messaging.class
│   ├── Project4$RemoteControllable.class
│   ├── Project4.class
│   ├── ProjectLib$1.class
│   ├── ProjectLib$CommitServing.class
│   ├── ProjectLib$Message.class
│   ├── ProjectLib$MessageHandling.class
│   ├── ProjectLib$RemoteInterface$1.class
│   ├── ProjectLib$RemoteInterface$2.class
│   ├── ProjectLib$RemoteInterface.class
│   └── ProjectLib.class
├── sample
│   ├── Makefile
│   ├── Server.java
│   └── UserNode.java
├── test.tar
└── tools
```
doc/ 里的文档，全都是针对 lib 里的 class 的说明.


