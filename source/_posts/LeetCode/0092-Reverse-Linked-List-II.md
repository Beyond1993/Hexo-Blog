---
title: 0092 Reverse Linked List II
date: 2019-06-15 03:15:46
categories: LeetCode
tags:
---


```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode reverseBetween(ListNode head, int m, int n) {
        if (m == n) {
            return head;
        }
        ListNode dd = new ListNode(-1);
        dd.next = head;
        ListNode dummy = new ListNode(-1);
        ListNode subCur = dummy;
        ListNode cur = head;
        int k = 0;
        
        ListNode beforeM = dd;
        ListNode nodeM = null;
        ListNode nodeN = null;
        ListNode nodeNPlus = null;
        
        while (cur != null) {
            ListNode next = cur.next;
            k++;
            
            if (k == m - 1) {
                beforeM = cur;
            }
            
            if (k == m) {
                nodeM = cur;
                cur.next = null;
            }
            
            if (nodeM != null && k <= n) {
                cur.next = dummy.next;
                dummy.next = cur;
            }
            
            if (k == n) {
                nodeN = cur;
            }
            
            if (k == n + 1) {
                nodeNPlus = cur;
            }
            cur = next;
        }
        
        if (beforeM != null)
            beforeM.next = dummy.next;
        if (nodeM != null)
            nodeM.next = nodeNPlus;
        
        return dd.next;
    }
}
```

```java

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseBetween(ListNode head, int m, int n) {
        if (head == null) {
            return null;
        }
        
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        for (int i = 0; i < m - 1; i++) {
             prev = prev.next;
        }
        ListNode start = prev.next;
        ListNode then = start.next;
        
        //n - m ensure avoid the null point
        for (int i = 0; i < n - m; i++) {
            start.next = then.next;
            then.next = prev.next;
            prev.next = then;
            then = start.next;
        }
        return dummy.next;
    }
}
```
