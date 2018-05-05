---
title: Debian Software Managerment
date: 2018-05-05 09:14:21
categories: Linux
tags:
---

Ubuntu是基于Debian的Linux系统，而Debian系统的软件是使用APT和dpkg进行管理。dpkg是"Debian Packager"的简写，是一个底层的软件包管理工具。


安装：sudo dpkg -i pacage-name.deb
1.查看软件的状态: dpkg -l。

先列举出libreoffice相关的软件，看哪些是已经安装的。命令为: dpkg -l libreoffice*

例：dpkg -l | grep nginx



un, ii, rc等是Desired和Status

ii就是已经安装的软件, rc则表示已经被删除，但配置文件还存在。



2.删除多余（rc）的配置文件

dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P



3.卸载软件:dpkg -P

因为dpkg --remove只是删除安装的文件，但不删除配置文件。而dpkg --purge则安装文件和配置文件都删除。

例子：sudo dpkg -P nginx

4，软件安装 .deb

sudo dpkg -i name.deb

依赖： sudo apt-get install -f


!!!!千万不要执行sudo apt-get autoremove --purge nginx
