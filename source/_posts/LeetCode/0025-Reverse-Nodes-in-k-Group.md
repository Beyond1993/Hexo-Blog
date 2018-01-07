---
title: 0025 Reverse Nodes in k-Group
date: 2018-01-07 01:17:28
categories: LeetCode
tags:
---


```java
public ListNode reverseKGroup(ListNode head, int k) {
      int n = 0;
      ListNode cur = head;
      while(cur != null){
        cur = cur.next;
        n++;
      }
      ListNode dmy = new ListNode(0);
      dmy.next = head;
      ListNode s = dmy, e = dmy.next; //s: start, e: end
      for(int i = n; i >= k; i -= k){
        for(int j = 1; j < k; j++){ // reverse group
          ListNode next = e.next;
          e.next = next.next;
          next.next = s.next;
          s.next = next;
        }
        s = e;
        e = s.next;
      }
      return dmy.next;
    }

```

先算出n个节点，在算出每start end 之间, reverse
