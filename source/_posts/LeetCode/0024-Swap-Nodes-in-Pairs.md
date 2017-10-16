---
title: 0024-Swap-Nodes-in-Pairs
date: 2017-10-16 05:34:20
categories: LeetCode
tags:
---

24. Swap Node in Pairs 

1->2->3->4 ==> 2->1->4->3



这题简单又易错，和反转的题目类似．



在循环的一开始，就要保存next.

link.png

while ( cur != null && cur.next != null) {
    next = cur.next;
    cur.next = next.next; //step1
    next.next = cur;      //step2
    prev.next = next;     //step3
    prev = cur;
    cur = cur.next;
}
