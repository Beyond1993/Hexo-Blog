---
title: Interview-Bloomberg
date: 2017-12-26 00:50:53
categories: Interview
tags:
---

给一个字典，里面包含很多词组什么的（我也不知道该叫什么好），比如{AppleTree，Pineapple，AppleTea}。让你实现一个功能，可以给一个input，返回字典里所有包含input的词组。比如pT是AppleTree，AppleTea的子串，所以你要返回AppleTree，AppleTea。

第二题，给一个组set，如{1, 2}, {2, 3}, {3, 4}, {5 ,6 ,7, 8}, {9}, {9}, merge互相关联的数到一个set里，互相关联就是曾今出现在一个set中，所以结果就是{1, 2, 3, 4}, {5, 6, 7, 8}, {9}
刚开始想用queue做，后来改用图+dfs了

Union Find
