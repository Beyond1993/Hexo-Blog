---
title: 0426 Convert Binary Search Tree to Sorted Double Linked List
date: 2019-06-15 19:01:44
categories: LeetCode
tags:
---

Questions: https://leetcode.com/problems/convert-binary-search-tree-to-sorted-doubly-linked-list/


```java
class Solution {
    Node last = null;
    Node head = null;
    public Node treeToDoublyList(Node root) {
         if (root == null) return null;
         helper(root);
         head.left = last;
         last.right = head;
         return head;
    }
    
    public void helper(Node node) {
        if (node == null) return;
        
        helper(node.left);
        
        if (last == null) {
            head = node;
        } else {
            last.right = node;
            node.left = last;
        }
        
        last = node;
        
        helper(node.right);
    }
}
```

if last is null. head refer to node.` 

