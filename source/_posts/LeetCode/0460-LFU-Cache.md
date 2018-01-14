---
title: 0460 LFU Cache
date: 2018-01-14 07:27:57
categories: LeetCode
tags:
---

Design and implement a data structure for Least Frequently Used (LFU) cache. It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reaches its capacity, it should invalidate the least frequently used item before inserting a new item. For the purpose of this problem, when there is a tie (i.e., two or more keys that have the same frequency), the least recently used key would be evicted.

Follow up:
Could you do both operations in O(1) time complexity?

Example:

LFUCache cache = new LFUCache( 2 /* capacity */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.get(3);       // returns 3.
cache.put(4, 4);    // evicts key 1.
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4


这题首先用了一个双链表，头节点是 frequence 最低的，nodeHash 就是 &lt;key, Node&gt;, 但是这个 node 里又有了 linkedHashSet 存 keys, 

再通过 valueHash &lt;key, value&t; 存数据.
```java
public class LFUCache {
    class Node {
        public int count = 0;
        public LinkedHashSet<Integer> keys = null;
        public Node prev = null, next = null;
        
        public Node(int count) {
            this.count = count;
            keys = new LinkedHashSet<Integer>();
            prev = next = null;
        }
    }
    private Node head = null;
    private int cap = 0;
    private HashMap<Integer, Integer> valueHash = null;
    private HashMap<Integer, Node> nodeHash = null;
    
    public LFUCache(int capacity) {
        this.cap = capacity;
        valueHash = new HashMap<Integer, Integer>();
        nodeHash = new HashMap<Integer, Node>();
    }
    
    public int get(int key) {
        if (valueHash.containsKey(key)) {
            increaseCount(key);
            return valueHash.get(key);
        }
        return -1;
    }
    
    public void set(int key, int value) {
        if ( cap == 0 ) return;
        if (valueHash.containsKey(key)) {
            valueHash.put(key, value);
        } else {
            if (valueHash.size() < cap) {
                valueHash.put(key, value);
            } else {
                removeOld();
                valueHash.put(key, value);
            }
            addToHead(key);
        }
        increaseCount(key);
    }
    
    private void addToHead(int key) {
        if (head == null) {
            head = new Node(0);
            head.keys.add(key);
        } else if (head.count > 0) {
            Node node = new Node(0);
            node.keys.add(key);
            node.next = head;
            head.prev = node;
            head = node;
        } else {
            head.keys.add(key);
        }
        nodeHash.put(key, head);      
    }
    
    private void increaseCount(int key) {
        Node node = nodeHash.get(key);
        node.keys.remove(key);
        
        if (node.next == null) {
            node.next = new Node(node.count+1);
            node.next.prev = node;
            node.next.keys.add(key);
        } else if (node.next.count == node.count+1) {
            node.next.keys.add(key);
        } else {
            Node tmp = new Node(node.count+1);
            tmp.keys.add(key);
            tmp.prev = node;
            tmp.next = node.next;
            node.next.prev = tmp;
            node.next = tmp;
        }

        nodeHash.put(key, node.next);
        if (node.keys.size() == 0) remove(node);
    }
    
    private void removeOld() {
        if (head == null) return;
        int old = 0;
        for (int n: head.keys) {
            old = n;
            break;
        }
        head.keys.remove(old);
        if (head.keys.size() == 0) remove(head);
        nodeHash.remove(old);
        valueHash.remove(old);
    }
    
    private void remove(Node node) {
        if (node.prev == null) {
            head = node.next;
        } else {
            node.prev.next = node.next;
        } 
        if (node.next != null) {
            node.next.prev = node.prev;
        }
    }
    
    
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * LFUCache obj = new LFUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
```
