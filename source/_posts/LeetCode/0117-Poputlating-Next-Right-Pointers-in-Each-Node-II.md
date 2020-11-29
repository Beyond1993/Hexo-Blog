---
title: 0117 Poputlating Next Right Pointers in Each Node II
date: 2018-04-29 20:13:16
categories: LeetCode
tags:
---

Given a binary tree

struct Node {
  int val;
  Node *left;
  Node *right;
  Node *next;
}
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.

 

Follow up:

You may only use constant extra space.
Recursive approach is fine, you may assume implicit stack space does not count as extra space for this problem.


constant space

```text

  root --> 1
          / \
         2   3
        / \   \
       4   5  7
  
root 是遍历每一个节点.　currentChild 是连
```

![](https://wfeng.s3.us-east-2.amazonaws.com/Leetcode/2B42184D-63AB-4C33-835B-C39343435D8C.png)


```java

public class Solution {
    public Node connect(Node root) {
        if(root == null) return null;
        Node cur = root;
        Node dummy = new Node(0);
        while(cur != null){
            dummy.next = null;
            Node curChild = dummy; // dummy 指向下一层
            while(cur != null){
                if(cur.left != null){
                    curChild.next = cur.left; // dummy.next 赋值一次 
                    curChild = curChild.next;
                }
                if(cur.right != null){
                    curChild.next = cur.right; // if cur.left == null, dummy.next 在这赋值
                    curChild = curChild.next;
                }
                cur = cur.next;   
            }
            cur = dummy.next;
        }
        return root;
    }
}
```



