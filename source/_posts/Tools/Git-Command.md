---
title: Git-Command
date: 2017-10-16 05:49:17
categories: Tools
tags:
---

step 1 

在github 上创建一个空的仓库 点击 new repository。起名 Test（随便起个就好），选public。

复制仓库链接 例如：https://github.com/Beyond1993/AWSweb.git

step2 

进入 要上传文件的目录

git init

git remote add origin https://github.com/Beyond1993/AWSweb.git

git push origin master.



git status



git stash 先把冲突文件存好

git pull --rebase origin master

git stash pop 再还原。



git reset --hard HEAD

git pull
