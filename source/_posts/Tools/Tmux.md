---
title: Tmux
date: 2018-05-05 09:11:57
categories: Tools
tags:
---

sudo apt-get install tmux

现在想在电脑关机的情况下，跑服务器上的程序。
通过 Tmux 使终端会话运行于后台：
先输入tmux, 再跑程序，再按ctrl + b 进入控制模式，再按d　退出．
tmux ls 列出所有　seesion
tmux attach -t 0  回到现场． -t 后加session 名，　可选．

速查表

https://gist.github.com/ryerh/14b7c24dfd623ef8edc7
