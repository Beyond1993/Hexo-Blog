---
title: Tmux
date: 2018-05-05 09:11:57
categories: Tools
tags:
---

现在想在电脑关机的情况下，跑服务器上的程序。通过 Tmux 使终端会话运行于后台：

sudo apt-get install tmux


启动新会话：
tmux [new -s 会话名 -n 窗口名]

恢复会话：
tmux at [-t 会话名]
tmux at -t 窗口序号

列出所有会话：
tmux ls

关闭会话：
tmux kill-session -t 会话名

回到主界面:
ctrl+b 进入控制模式， 再按d退出

速查表

https://gist.github.com/ryerh/14b7c24dfd623ef8edc7
