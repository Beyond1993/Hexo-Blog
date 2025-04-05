---
title: 0155 Min Stack
date: 2019-10-23 00:29:38
categories: LeetCode
tags:
---


Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
getMin() -- Retrieve the minimum element in the stack.
 

Example:

MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin();   --> Returns -3.
minStack.pop();
minStack.top();      --> Returns 0.
minStack.getMin();   --> Returns -2.

无脑放两次, 先放min, 再放x
```java
public class MinStack {
    
    Stack<Integer> stack;
    /** initialize your data structure here. */
    public MinStack() {
        stack = new Stack<Integer>();
    }
    
    public void push(int x) {
        
        //这里一定是 <= 
        if (stack.isEmpty() || x < getMin()) {
            stack.push(x);
        } else {
            stack.push(getMin());
        }
        
        stack.push(x);
    }
    
    public void pop() {
        stack.pop();
        stack.pop();
    }
    
    public int top() {
        return stack.peek();
    }
    
    public int getMin() {
        int result = stack.pop();
        int min = stack.pop();
        int res = min;
        stack.push(min);
        stack.push(result);
        return res;
    }
}
```

这里有个优化，就是减少空间使用，只有在 x <= min 的时候push, 这样减少一个space

```java
public class MinStack {
    int min = Integer.MAX_VALUE;
    Stack<Integer> stack;
    /** initialize your data structure here. */
    public MinStack() {
        stack = new Stack<Integer>();
    }
    
    public void push(int x) {
        
        //这里一定是 <= 
        // 因为 min 可能要有好几个.
        if (x <= min) {
            stack.push(min);
            min = x;
        }
        
        stack.push(x);
    }
    
    public void pop() {
        int result = stack.pop();
        if (result <= min) {
           min = stack.pop();
        }
    }
    
    public int top() {
        return stack.peek();
    }
    
    public int getMin() {
        return min;
    }
}
```
