---
title: LeetCode-String
date: 2017-10-16 06:04:38
categories: LeetCode-Index
tags:
---


字符串： 是一个一种数据类型，也是刷题的一个大类，难度从easy 到 hard 不等。
其中包含了，链表，数组，回溯，递归，动态规划等等数据结构和算法，包罗万象，变化复杂。

字符串在面试题中，大部分会涉及到整个串和小串。

这时候的子串窗口的方法就格外有用。

其中窗口的概念是解题的关键。



此类题的通解：

第一步：先取到这样第一个窗口

第二步：在对窗口里的内容操作。



3 Longest Substring Without Repeating Characters22.5% Medium

最长不重复字符的子串：



这题的标签是：string , two point,  hash table





这里的双指针法，其实叫窗口法更为贴切，这里取相邻两个字符间的字符串为一个窗口。



以"tmabmzuxt" 为例：



第一个取到的窗口应是mabm,

再这个窗口里，begin 到第一个m 就停止，所以长度是3.



口诀：

     最长不重复子串长度

end   向前进 ，一直到尽头。

一路设成true. length步步有，

遇上同字符，   Begin向前走，

相同就停手，   路上还原否。


