---
title: 0023 Merge k Sorted Lists
date: 2017-12-31 21:49:19
categories: LeetCode
tags:
---

### 递归
```java
public class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        return sort(lists, 0, lists.length - 1);
    }
    
    private ListNode sort(ListNode[] lists, int lo, int hi) {
        if (lo >= hi) return lists[lo];
        int mid = lo + (hi - lo) / 2;
        ListNode l1 = sort(lists, lo, mid);
        ListNode l2 = sort(lists, mid + 1, hi);
        return merge(l1, l2);
    }
    
    private ListNode merge(ListNode l1, ListNode l2) {
        if (l1 == null) return l2;
        if (l2 == null) return l1;
        if (l1.val < l2.val) {
            l1.next = merge(l1.next, l2);
            return l1;
        }
        l2.next = merge(l1, l2.next);
        return l2;
    }
}
```

### O(1) with dummy node
```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists.length == 0) {
            return null;
        }
        return divide(lists, 0, lists.length - 1);
    }
    
    
    ListNode divide(ListNode[] lists, int left,int right) {
        if (left  == right) {
            return lists[left];
        }
        
        int mid = left + (right - left)  / 2;
        
        ListNode node1 = divide(lists, left, mid);
        ListNode node2 = divide(lists, mid + 1, right);
        
        ListNode result = merge(node1, node2);
        return result;
    }
    
    private ListNode merge(ListNode node1, ListNode node2) {
        ListNode dummy = new ListNode(-1);
        
        ListNode tail = dummy;
        
        while(node1 != null && node2 != null) {
            if (node1.val < node2.val) {
                tail.next = node1;
                node1 = node1.next; 
            } else {
                tail.next = node2;
                node2 = node2.next;
            }
            tail = tail.next;
        }
        
        if (node1 == null) {
            tail.next = node2;
        } else {
            tail.next = node1;
        }
        return dummy.next;
    }
}
```
