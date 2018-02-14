---
title: 0341 Flatten Nested List Iterator
date: 2018-01-26 04:50:04
categories: LeetCode
tags:
---

Given a nested list of integers, implement an iterator to flatten it.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Example 1:
Given the list [[1,1],2,[1,1]],

By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,1,2,1,1].

Example 2:
Given the list [1,[4,[6]]],

By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,4,6].


```java
class NestedIterator implements Iterator<Integer> {

    Stack<NestedInteger> stack = new Stack<>();
    
    public NestedIterator(List<NestedInteger> nestedList) {
        for(int i = nestedList.size() - 1; i >= 0; i--) {
            stack.push(nestedList.get(i));
        }
    }

    @Override
    public Integer next() {
        return stack.pop().getInteger();
    }

    @Override
    public boolean hasNext() {
        while(!stack.isEmpty()) {
            NestedInteger curr = stack.peek();
            if(curr.isInteger()) {
                return true;
            }
            stack.pop();
            for(int i = curr.getList().size() - 1; i >= 0; i--) {
                stack.push(curr.getList().get(i));
            }
        }
        return false;
    }
}
```

另一种写法，就是先展开，再处理.

```java
public class NestedIterator implements Iterator<Integer> {

  private List<Integer> flattenedList;
  private Iterator<Integer> it;

  public NestedIterator(List<NestedInteger> nestedList) {
      flattenedList = new LinkedList<Integer>();
      flatten(nestedList);
      it = flattenedList.iterator();
  }


  private void flatten(List<NestedInteger> nestedList) {
      for (NestedInteger i : nestedList) {
          if (i.isInteger()) {
              flattenedList.add(i.getInteger());
          } else {
              flatten(i.getList());
          }
      }
  }

  @Override
  public Integer next() {
      return it.next();
  }

  @Override
  public boolean hasNext() {
      return it.hasNext();
  }
}
```



