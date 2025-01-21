---
title: Interview-DoorDash
date: 2025-01-21 07:47:42
categories: Interview
tags:
---

给一个数组[1,3,2,...]和一个字符串比如FW?FF??W，数组里的每个数代表连续的F的个数（比如1可以对标FWW或者WFW或者），字符串中的每个问号可以代替一个F或一个W。问这个字符串一共可以组成多少种有效的FW组合。

比如数组是[1,2]而字符串是?W??FW，那valid pattern就只有有FWWFFW一种（不可以是WWFFFW因为中间的1+2已经是连续的3了）。
但如果数组是[1,1]那么?WW??就可以有FWWWF和FWWFW两种。
而数组[1,1]和字符串WW??W应该返回0，因为没有valid pattern（没有两个分开的长度为1的F）
