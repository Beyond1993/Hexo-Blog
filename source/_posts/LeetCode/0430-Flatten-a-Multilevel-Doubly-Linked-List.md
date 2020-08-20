---
title: 0430 Flatten a Multilevel Doubly Linked List
date: 2020-05-23 07:37:15
categories: LeetCode
tags:
---


```java
/*
// Definition for a Node.
class Node {
    public int val;
    public Node prev;
    public Node next;
    public Node child;
};
*/

class Solution {
    public Node flatten(Node head) {
        if (head == null) {
            return null;
        }
    
        Node cur = head;
        Node prev = null;
        while(cur != null) {
            if (cur.child != null) {
                Node next = cur.next;
                Node h = flatten(cur.child);
                Node c = h;
                while(c.next != null) {
                    c = c.next;
                }
                cur.next = h;
                cur.child = null;
                h.prev = cur;
                if (next != null) {
                    c.next = next;
                    next.prev = c;
               } 

            } else {
               cur = cur.next; 
            }
        }
        return head;  
    }
}
```

优化
```java
class Solution {
    public Node flatten(Node head) {
        if (head == null) {
            return null;
        }
        return dfs(head)[0];
    }
    
    public Node[] dfs(Node head) {
        if (head == null) {
            return null;
        }
    
        Node cur = head;
        Node prev = null;
        while(cur != null) {
            prev = cur; 
            if (cur.child != null) {
                Node next = cur.next;
                Node[] t = dfs(cur.child);
                Node h = t[0];
                Node c = t[1];
                cur.next = h;
                cur.child = null;
                h.prev = cur;
                if (next != null) {
                    c.next = next;
                    next.prev = c;
               } 

            } else {
               cur = cur.next; 
            }
        }
        Node[] res = new Node[2];
        res[0] = head;
        res[1] = prev;
        return res;  
    }
}
```

更优的递归
```java
class Solution {
    public Node flatten(Node head) {
        List<Node> res = flattenHelper(head);
        return res.get(0);
    }
    
    private List<Node> flattenHelper(Node head) {
        // return the [head, tail] of the flattened linked list.
        // head should always be the head.
        // tail should be the one that decided by the recursive logic.
        if (head == null) {
            return Arrays.asList(null, null);
        }
        List<Node> res = new ArrayList<>();
        Node cur = head;
        res.add(head);
        Node next = head.next;
        if (head.child != null) {
            List<Node> child_res = flattenHelper(head.child);
            head.next = child_res.get(0);
            child_res.get(0).prev = head;
            cur = child_res.get(1);
            head.child = null;
        }
        
        if (next == null) {
            res.add(cur);
            return res;
        }
        
        List<Node> next_res = flattenHelper(next);
        cur.next = next;
        next.prev = cur;
        res.add(next_res.get(1));
        return res;
    }
}
```

用stack
```java

```

最优解
```java
class Solution {
    public Node flatten(Node head) {
        if( head == null) return head;
    // Pointer
        Node p = head; 
        while( p!= null) {
            /* CASE 1: if no child, proceed */
            if( p.child == null ) {
                p = p.next;
                continue;
            }
            /* CASE 2: got child, find the tail of the child and link it to p.next */
            Node temp = p.child;
            // Find the tail of the child
            while( temp.next != null ) 
                temp = temp.next;
            // Connect tail with p.next, if it is not null
            temp.next = p.next;  
            if( p.next != null )  p.next.prev = temp;
            // Connect p with p.child, and remove p.child
            p.next = p.child; 
            p.child.prev = p;
            p.child = null;
        }
        return head;
    }
}
```


