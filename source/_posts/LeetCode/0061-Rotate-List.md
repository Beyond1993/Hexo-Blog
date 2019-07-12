---
title: 0061 Rotate List
date: 2019-07-12 01:50:05
categories: LeetCode
tags:
---


```java
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode rotateRight(ListNode head, int k) {
       if (head == null || head.next == null) return head;
       if (k == 0) return head;
           
       ListNode dummy = new ListNode(-1);
       ListNode tail = head;
       int count = 1;
       while(tail.next!=null) {
           tail = tail.next;
           count++;
       }
       if (k % count == 0) return head;
     
       ListNode breakPoint = head;
       int i = 0;
        for (; i + 1< count - k % count; i++) {
           breakPoint = breakPoint.next;
       }
        
       dummy.next = breakPoint.next;
       breakPoint.next = null;
       tail.next = head;
        
       return dummy.next;
    }
}
```
