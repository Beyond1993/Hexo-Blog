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

git pull --rebase origin master 或者直接 git rebase origin/master

git stash pop 再还原。


版本回退：
git reset --hard HEAD
git reset --hard HEAD^ ^ 表示上一版本
git reset --hard HEAD^^ 上上一个版本
git reset --hasr HEAD~100 上100个版本

git log
git reset --hard commit_id 某一版本

git pull : is what you would do to bring a local branch up-to-date with its remote version, while also updating your other remote-tracking branches.

更新单个文件.
git checkout origin/master -- pinflow_workflows/m10n/jobs.py

创建分支:
不论增加什么代码的时候，都new branch， 然后合并
git checkout -b keyword-normalization

查看 git branch graph
git log --all --graph --decorate --oneline --simplify-by-decoration

同步远程master
# fetch from the default remote, origin
git fetch :In the simplest terms, git pull does a git fetch followed by a git merge.
# reset your current branch (master) to origin's master
git reset --hard origin/master


git --squash

land code
git fetch
git rebase origin/master

arc diff
arc land


https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/

使用rebase 的主要目的，就是解决commit tree 过于复杂的问题


fecth remote branch as local new branch

git checkout --track update/jenkins
