---
title: 0206 Reverse Linked List
date: 2018-02-22 08:15:44
categories: LeetCode
tags:
---


Reverse a singly linked list

Recursion

```java
public class Solution {
    private ListNode reverseList(ListNode head, ListNode prev) {
        if (head == null) {
            return prev;
        }
        ListNode next = head.next;
        head.next = prev;
        return reverseList(next, head);
    }
    public ListNode reverseList(ListNode head) {
        return reverseList(head,null);
    }
}
```

这个reverse 很简单，就是两两交换当前的值。一个是当前的值，一个是prev


