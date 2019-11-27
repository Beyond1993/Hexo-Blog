---
title: 0146 LRU Cache
date: 2019-07-10 02:54:27
categories:
tags:
---


新的数据insert 到双链表头， 链表尾 记录最早的记录

```java

class LRUCache {
    Node tail;
    Node head;
    private final int limit;
    HashMap<Integer,Node> map;
    public LRUCache(int capacity) {
       limit = capacity;
       map = new HashMap<Integer,Node>();
    }
    
    public int get(int key) {
    	int res = -1;
    	if (map.containsKey(key)) {
    		Node n = map.get(key);
    		res = n.val;
    		remove(n);
    		append(n);
    	}
    	return res;
    }
    
    public void put(int key, int value) {
    	Node n = null;
    	if (get(key)==-1) {
    		n = new Node(key,value);
    		if (map.size()>=limit) {
    			remove(tail);
    		}
    	} else {
    		n = map.get(key);
    		n.update(key,value);
    		remove(n);
    	}
    	append(n);
    }
    private Node remove(Node n) {
    	map.remove(n.key);
    	if (n.next != null) {
    		n.next.prev = n.prev;
    	}
    	if (n.prev != null) {
    		n.prev.next = n.next;
    	}
    	if (n==head) {
    		head = n.next;
    	}
    	if (n==tail) {
    		tail = n.prev;
    	}
    	n.next=n.prev=null;
    	return n;
    }
    private Node append(Node n) {
    	map.put(n.key,n);
    	if (head==null) {
    		head = n;
    		tail = n;
    	} else {
    		n.next = head;
    		head.prev = n;
    		head = n;
    	}
    	return n;
    }
}
    class Node{
    	int val;
    	int key;
        Node prev; //忘了
        Node next;//忘了
    	public Node(int key,int val) {
    		this.key = key;
    		this.val = val;
    	}
    	void update(int key, int val) {
    		this.key = key;
    		this.val = val;
    	}
    }

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
```

```java
class LRUCache extends LinkedHashMap<Integer, Integer> {
    
    private int capacity;
    
    public LRUCache(int capacity) {
        super(capacity, 0.75F, true);
        this.capacity = capacity;
    }
    
    public int get(int key) {
        return super.getOrDefault(key, -1);
    }
    
    public void put(int key, int value) {
        super.put(key, value);
    }
    
    @Override
    protected boolean removeEldestEntry(Map.Entry<Integer, Integer> eldest) {
        return size() > capacity;
    }
}
```
