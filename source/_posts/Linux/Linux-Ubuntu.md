---
title: Linux-Ubuntu
date: 2018-05-05 09:17:13
categories: Linux
tags:
---

## terminal 字体缩放
缩小 ctrl 加 -
放大 ctrl 加 shift 加 +

## 下载 youtube 视频

通过命令youtube-dl下载YouTube视频。
安装youtube-dl

复制代码代码如下:

$ sudo apt-get install youtube-dl

安装完毕后就可以用下面的格式下载TouTube视频：

复制代码代码如下:

$ youtube-dl url-to-video

## w3m 命令行浏览器
sudo apt-get install w3m

## 录屏
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get install update
sudo apt-get install simplescreenrecorder

because there is no sound with recordmydesktop, I find the simplescreenrecorder solve the problem perfectly!!

## Eclipse 创建桌面快捷方式
ln -s /home/wayne/eclipse/jee-neon2/eclipse/eclipse ~/Desktop/eclipse
