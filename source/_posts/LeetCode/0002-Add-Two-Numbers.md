---
title: 0002-Add-Two-Numbers
date: 2017-12-05 01:07:37
categories: LeetCode
tags:
---

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
Explanation: 342 + 465 = 807.

这一题本质就是模拟一个加法器
每次迭代:
**sum =  l2.val +  l1.val + carry**

还有巧妙的一点是, 当指针为NULL 时， 直接取0

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
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode dummy = new ListNode(0);
        ListNode prev = dummy;
        int carry = 0;
        while (l1 != null || l2 != null || carry != 0) {
            ListNode cur = new ListNode(0);
            int sum = ((l2 == null) ? 0 : l2.val) + ((l1 == null) ? 0 : l1.val) + carry;
            cur.val = sum % 10;
            carry = sum / 10;
            prev.next = cur;
            prev = cur;
            
            l1 = (l1 == null) ? l1 : l1.next;
            l2 = (l2 == null) ? l2 : l2.next;
        }
        return dummy.next;
    }
}
```

```cpp
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    ListNode * dummy = new ListNode(0);
    ListNode * prev = dummy;
    int carry = 0;
    while(l1 != NULL || l2 != NULL || carry != 0) 
    {
        ListNode * cur = new ListNode(0);
        int sum = ((l2 == NULL) ? 0 : l2->val) + ((l1 == NULL) ? 0 : l1->val) + carry;
        cur->val = sum % 10;
        carry = sum / 10;
        prev->next = cur;
        prev = cur;


        l1 = (l1 == NULL) ? NULL : l1->next;
        l2 = (l2 == NULL) ? NULL : l2->next;
    }
    return dummy->next;
}
```
