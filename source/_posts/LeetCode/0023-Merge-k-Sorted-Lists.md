---
title: 0023 Merge k Sorted Lists
date: 2017-12-31 21:49:19
categories: LeetCode
tags:
---

You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

Merge all the linked-lists into one sorted linked-list and return it.

 

Example 1:

Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
Explanation: The linked-lists are:
[
  1->4->5,
  1->3->4,
  2->6
]
merging them into one sorted list:
1->1->2->3->4->4->5->6
Example 2:

Input: lists = []
Output: []
Example 3:

Input: lists = [[]]
Output: []
 

Constraints:

k == lists.length
0 <= k <= 104
0 <= lists[i].length <= 500
-104 <= lists[i][j] <= 104
lists[i] is sorted in ascending order.
The sum of lists[i].length will not exceed 10 ^ 4.


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

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

class HeapNode:
    def __init__(self, node):
        self.node = node
    def __lt__(self, other):
        return self.node.val < other.node.val

class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        heap = []
        for list_ in lists:
            if list_:
                heapq.heappush(heap, HeapNode(list_))
        dummy = ListNode(-1)
        tail = dummy
        while heap:
            heap_node = heapq.heappop(heap)
            node = heap_node.node
            tail.next = node
            tail = node
            if node.next:
                heapq.heappush(heap, HeapNode(node.next))

        return dummy.next
```
