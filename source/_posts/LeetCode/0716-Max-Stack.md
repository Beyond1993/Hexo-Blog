---
title: 0716 Max Stack
date: 2019-06-29 22:59:11
categories: LeetCode
tags:
---

Design a max stack that supports push, pop, top, peekMax and popMax.

push(x) -- Push element x onto stack.
pop() -- Remove the element on top of the stack and return it.
top() -- Get the element on the top.
peekMax() -- Retrieve the maximum element in the stack.
popMax() -- Retrieve the maximum element in the stack, and remove it. If you find more than one maximum elements, only remove the top-most one.
Example 1:
MaxStack stack = new MaxStack();
stack.push(5); 
stack.push(1);
stack.push(5);
stack.top(); -> 5
stack.popMax(); -> 5
stack.top(); -> 1
stack.peekMax(); -> 5
stack.pop(); -> 1
stack.top(); -> 5
Note:
-1e7 <= x <= 1e7
Number of operations won't exceed 10000.
The last four operations won't be called when stack is empty.

正常的stack, 有三个功能 push top pop

现在只要考虑两个问题: peekMax, popMax

这题有两个解法，

解法一： 用两个stack

一个stack 存正常的值，另一个 stack 存当前最大值.
比如 input = [2,1,5,3,9]

stack = [2,1,5,3,9]
stackMax = [2,2,5,5,9];

这样子处理有一个问题就是
popMax 的时候，这个值可能在 正常 stack 的中间位置。这时候相当于要用一个buffer stack 过渡一下 

```java
class MaxStack {

    Stack<Integer> stack;
    Stack<Integer> maxStack;
    /** initialize your data structure here. */
    public MaxStack() {
        this.stack = new Stack<Integer>();
        this.maxStack = new Stack<Integer>();
    }
    
    public void push(int x) {
        stack.push(x);
        
        if (maxStack.isEmpty()) {
            maxStack.push(x);
            return;
        }
        
        if (x >= maxStack.peek()) {
            maxStack.push(x);
        } else {
            maxStack.push(maxStack.peek());
        } 
    }
    
    public int pop() {
        maxStack.pop();
        return stack.pop();
    }
    
    public int top() {
        return stack.peek();
    }
    
    public int peekMax() {
        return maxStack.peek();
    }
    
    public int popMax() {
        int max = peekMax();
        
        Stack<Integer> buffer = new Stack();
        
        
        while(top() != max) {
            buffer.add(pop());
        }
        
        pop();
        
        while(!buffer.isEmpty()) {
            push(buffer.pop());
        }
        
        return max;
    }
}

/**
 * Your MaxStack object will be instantiated and called as such:
 * MaxStack obj = new MaxStack();
 * obj.push(x);
 * int param_2 = obj.pop();
 * int param_3 = obj.top();
 * int param_4 = obj.peekMax();
 * int param_5 = obj.popMax();
 */
```

解法二是 double linked list + treeMap

treeMap 的 key 是 number, value is doubled linked list.


```java
class MaxStack {
    TreeMap<Integer, List<Node>> map;
    DoubleLinkedList dll;

    public MaxStack() {
        map = new TreeMap();
        dll = new DoubleLinkedList();
    }

    public void push(int x) {
        Node node = dll.add(x);
        if(!map.containsKey(x))
            map.put(x, new ArrayList<Node>());
        map.get(x).add(node);
    }

    public int pop() {
        int val = dll.pop();
        List<Node> L = map.get(val);
        L.remove(L.size() - 1);
        if (L.isEmpty()) map.remove(val);
        return val;
    }

    public int top() {
        return dll.peek();
    }

    public int peekMax() {
        return map.lastKey();
    }

    public int popMax() {
        int max = peekMax();
        List<Node> L = map.get(max);
        Node node = L.remove(L.size() - 1);
        dll.unlink(node);
        if (L.isEmpty()) map.remove(max);
        return max;
    }
}

class DoubleLinkedList {
    Node head, tail;

    public DoubleLinkedList() {
        head = new Node(0);
        tail = new Node(0);
        head.next = tail;
        tail.prev = head;
    }

    public Node add(int val) {
        Node x = new Node(val);
        x.next = tail;
        x.prev = tail.prev;
        tail.prev = tail.prev.next = x;
        return x;
    }

    public int pop() {
        return unlink(tail.prev).val;
    }

    public int peek() {
        return tail.prev.val;
    }

    public Node unlink(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        return node;
    }
}

class Node {
    int val;
    Node prev, next;
    public Node(int v) {val = v;}
}
```
相当于把双链表当作stack 用，每次push 就把节点放入tail 前一个位置。一开始初始化成 head tail 两个dummy 互指也是为了之后的代码方便。
