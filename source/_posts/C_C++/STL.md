---
title: STL
date: 2017-10-16 06:36:42
categories: C/C++
tags:
---

C++ STL中的remove和erase函数曾经让我迷惑，同样都是删除，两者有什么区别呢？



vector中的remove的作用是将等于value的元素放到vector的尾部，但并不减少vector的size

vector中erase的作用是删除掉某个位置position或一段区域（begin, end)中的元素，减少其size



list容器中的remove 成员函数，原型是void remove (const value_type& val);

他的作用是删除list中值与val相同的节点，释放该节点的资源。



而list容器中的erase成员函数，原型是iterator erase (iterator position);

作用是删除position位置的节点。这也是与remove不同的地方。

考虑到list::erase是与位置有关，故erase还存在API:   iterator erase (iterator first, iterator last);

对于list 来说，什么时候用 remove 什么时候用 erase ?

erase 删除指定地址上的单个元素，remove 可以删除多个相同元素



对于set来说，只有erase API，没有remove API。 erase 的作用是把符合要求的元素都删掉。

(1) void erase (iterator position);
(2) size_type erase (const value_type& val);
(3) void erase (iterator first, iterator last);





综上所述，erase一般是要释放资源，真正删除元素的，

而remove主要用在vector中，用于将不符合要求的元素移到容器尾部，而并不删除不符合要求的元素


