---
title: 340-Longest-Substring-with-At-Most-K-Distinct-Characters
date: 2017-10-04 03:31:12
categories: LeetCode
tags:
---

这题用subline windows 的模版做。

follow up 难就难在，不能用 priority queue. 
其实想要实现的是，按照value 排好序的HashMap, 这样每次都可以拿出最小值，其实就是heap hashmap的结合，但是并不好实现，因为如果将entry 作为一个对象存入 heap, 解决不了update的问题。
如果将整个hashMap 作为对象。做不到排序。

如果用linkedHashMap，只能做到按照put进map的顺序来显示，除非每次都sort。

既然linkedHashMap 自然而然就想到了双链表。

重点来了，链表和HashMap 之间的关系!!! 在此之前，这一环是缺失的

双链表加HashMap 使得get set的时间复杂度降到O(1)


最优解

```java
class Solution {
  class Node {
        int key;
        int value;
        Node prev;
        Node next;
        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
  }
      
  class LRUCache {
    final int Capacity;
    Map<Integer, Node> map;
    Node head;
    Node tail;
    
    public LRUCache(int capacity) {
        this.Capacity = capacity;
        map = new HashMap<Integer, Node>();
        head = new Node(0,0);
        tail = new Node(0,0);
        head.next = tail;
        tail.prev = head;
    }
    
    private void update(Node node) {
        delete(node);
        add(node);
    }
    
    private void delete(Node node) {
        Node prevNode = node.prev;
        Node next = node.next;
        prevNode.next = node.next;
        next.prev = node.prev; 
    }
    
    private void add(Node node) {
        node.next = head.next;
        head.next.prev = node;
        head.next = node;
        node.prev = head;
    }
    public int get(int key) {
        Node node = map.get(key);
        if (node == null) {
            return -1;
        } else {
            update(node);
            return node.value;
        }
    }
    
    public Node put(int key, int value) {
        Node node = map.get(key);
        if (node == null) {
            node = new Node(key, value);
            if (map.size() < this.Capacity) {
                
                map.put(key, node);
                add(node);
    
            } else {
                return LRU(node);
            } 
        } else {
            node.value = value;
            map.put(key, node);
            update(node);
            
        }
        return null;
    }
    
    private Node LRU(Node node) {
        Node result = new Node(tail.prev.key, tail.prev.value) ;
        map.remove(tail.prev.key);
        delete(tail.prev);
        
        map.put(node.key, node);
        add(node);
        return result;
        
    }
    
}
    public int lengthOfLongestSubstringKDistinct(String s, int k) {
        if(s == null || s.isEmpty() || k == 0) {
            return 0;
        }
        LRUCache lru = new LRUCache(k);
        int len = s.length();
        int max = Integer.MIN_VALUE;
        int window_len = 0;
        for (int i = 0; i < len; i++) {
            int c = s.charAt(i) - 'a';
            
            Node remove_node = lru.put(c,i);
            if (remove_node != null) {
                window_len = i - remove_node.value;
            } else {
                window_len++;
            }
            if (window_len > max) {
                max = window_len;
            }
            //System.out.println(s.charAt(i) + " " + window_len + " " + max);
        }
        return max;
    }
}
```
