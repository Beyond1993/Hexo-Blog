---
title: CMU-15213-Linker
date: 2017-12-10 21:55:49
categories: CMU
tags:
---

Linker 是将object file 链接在一起


分为两步：
1. Symbol Resolution
http://blog.csdn.net/jeason29/article/details/45716989

2. Relocation

Merges separate code and data sections into single sections

Relocates symbols from their relative locations in the .o files to their final absolute memory locations in the executable.

Updates all references to these symbols to reflect their new positions 

![](http://img.blog.csdn.net/20141120144640019?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbG92ZV9nYW9oeg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
