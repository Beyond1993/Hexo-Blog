---
title: LeetCode-Linked-List
date: 2017-10-16 06:16:44
categories: LeetCode-Index
tags:
---

链表是面试最常见的题目，因为链表一般思路简单，但是实现起来却有很多细节要考虑。一旦思路不对，就会陷入各种指针跳来跳去的尴尬。

链表的操作：

１，链表找中点：



ListNode slow = head, fast = head.next;

while( fast != null && fast.next != null) {

     fast = fast.next.next;

     slow = slow.next;

}



注意点1: fast 是从head.next 开始，而不是head 开始．因为如果从head 开始，那链表数是偶数时，会找到中点的后一点．

注意点2:终止条件 fast != null 针对于链表个数为奇数， fast.next != null 针对于链表个数是偶数．



这和数组的中点, length / 2 的结果是一致的.  







２，反转 25. Reverse Nodes in K-Group.

之前以为链表反转很简单，谁知今天做了好长时间才做出来，主要还是思路不明确。痛定思痛，好好整理

其实反转所有的操作都是针对current 指针的，短短四行代码，浓缩的都是精华。

设置 last 和 cur 指针 分别指向链表的前两个节点（当然dumy节点不算),

第一步：把cur节点分离出来，把cur的下一个节点 用last 把链表连上 last->next = cur->next;

第二步和第三步是一个操作：把cur 节点插入dumy 和第一个节点之间 cur->next = pre->next; pre->next = cur;

第四步：将cur 指针后移一位， cur = last->next;

while(cur != NULL){

    last->next = cur->next;

    cur->next = pre->next;

    pre->next = cur;

    cur = last->next;

}

这是一个完美的圈。

注意：

1,不能用随便new一个节点 tmp 保存 cur->next, 不然会断链

2,pre 与 last 指针指向的节点是不变的， 变得只有cur 指向的节点，变与不变。

3,不能 用 cur 代替 cur->next = pre->next 里的 pre->next, 因为不是两个节点相互反转，而是不断的往前插入

以 0->1->2->3->4 为例：

一句话总结：current 插向前，0,1 永不变。

链表的问题：

1，dumy 节点

2，断链

3，空指针

4，迭代时的指针逻辑错误



反转链表的迭代写法．



２．Add Two Numbers




