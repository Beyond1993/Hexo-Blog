---
title: Integer ID Management
date: 2018-09-16 20:17:00
categories: Linux
tags:
---

IDR 数据结构用于映射用户空间的UID, 比如将 inodify watch 的描述符或者POSIX的定时器 ID 映射到内核中相关联的数据结构上。

而这个映射是通过 Radix Tree (基数树)。


[Radix Tree](https://blog.csdn.net/yang_yulei/article/details/46371975)
[32叉树](https://www.linuxidc.com/Linux/2016-12/138233.htm?utm_source=tuicool&utm_medium=referral)
使用一个比特位判断，会使树的高度过高，非叶节点过多。故在实际应用中，我们一般是使用多个比特位作为树节点的判断，但多比特位会使节点的子节点槽变多，增大节点的体积，一般选用2个或4个比特位作为树节点即可）
