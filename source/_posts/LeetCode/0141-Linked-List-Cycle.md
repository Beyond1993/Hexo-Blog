---
title: 0141 Linked List Cycle
date: 2018-02-16 23:45:26
categories: LeetCode
tags:
---


Given a linked list, determine if it has a cycle in it.

Follow up:
Can you solve it without using extra space?

```java
public class Solution {
    public boolean hasCycle(ListNode head) {
        if(head==null) return false;
        ListNode walker = head;
        ListNode runner = head;
        while(runner.next!=null && runner.next.next!=null) {
            walker = walker.next;
            runner = runner.next.next;
            if(walker==runner) return true;
        }
        return false;
    }
}
```


在面 23andMe 时候电面 面的是 detect and remove the circle
