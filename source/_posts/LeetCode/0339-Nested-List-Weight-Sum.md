---
title: 0339 Nested List Weight Sum
date: 2018-01-26 04:47:50
categories: LeetCode
tags:
---

Given a nested list of integers, return the sum of all integers in the list weighted by their depth.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Example 1:
Given the list [[1,1],2,[1,1]], return 10. (four 1's at depth 2, one 2 at depth 1)

Example 2:
Given the list [1,[4,[6]]], return 27. (one 1 at depth 1, one 4 at depth 2, and one 6 at depth 3; 1 + 4*2 + 6*3 = 27)


全局变量破坏了 代码封装性，多线程环境下很容易出问题

```java
public class Solution {
    int sum;
    private void search(List<NestedInteger> nestedList, int depth) {
        if (nestedList == null) return;
        for (NestedInteger value : nestedList) {
            if (value.isInteger()) {
                //System.out.println(value.getInteger()+ " " + depth);
                sum += value.getInteger() * depth;
            } else {
                search(value.getList(), depth + 1);
            }
        }
    }
    public int depthSum(List<NestedInteger> nestedList) {
        search(nestedList, 1);
        return sum;
    }
}
```

不用全局变量的写法


```java
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * public interface NestedInteger {
 *     // Constructor initializes an empty nested list.
 *     public NestedInteger();
 *
 *     // Constructor initializes a single integer.
 *     public NestedInteger(int value);
 *
 *     // @return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public boolean isInteger();
 *
 *     // @return the single integer that this NestedInteger holds, if it holds a single integer
 *     // Return null if this NestedInteger holds a nested list
 *     public Integer getInteger();
 *
 *     // Set this NestedInteger to hold a single integer.
 *     public void setInteger(int value);
 *
 *     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 *     public void add(NestedInteger ni);
 *
 *     // @return the nested list that this NestedInteger holds, if it holds a nested list
 *     // Return empty list if this NestedInteger holds a single integer
 *     public List<NestedInteger> getList();
 * }
 */
class Solution {
    public int depthSum(List<NestedInteger> nestedList) {
        return dfs(nestedList, 1);
    }

    private int dfs(List<NestedInteger> nestedList, int depth) {
        int levelSum = 0;
        for(NestedInteger nested : nestedList) {
            if (nested.isInteger()) {
                levelSum = levelSum + nested.getInteger() * depth;

            } else {
                levelSum = levelSum + dfs(nested.getList(), depth + 1);
            }
        }
        return levelSum;
    }
}
```

```python
# """
# This is the interface that allows for creating nested lists.
# You should not implement it, or speculate about its implementation
# """
#class NestedInteger:
#    def __init__(self, value=None):
#        """
#        If value is not specified, initializes an empty list.
#        Otherwise initializes a single integer equal to value.
#        """
#
#    def isInteger(self):
#        """
#        @return True if this NestedInteger holds a single integer, rather than a nested list.
#        :rtype bool
#        """
#
#    def add(self, elem):
#        """
#        Set this NestedInteger to hold a nested list and adds a nested integer elem to it.
#        :rtype void
#        """
#
#    def setInteger(self, value):
#        """
#        Set this NestedInteger to hold a single integer equal to value.
#        :rtype void
#        """
#
#    def getInteger(self):
#        """
#        @return the single integer that this NestedInteger holds, if it holds a single integer
#        Return None if this NestedInteger holds a nested list
#        :rtype int
#        """
#
#    def getList(self):
#        """
#        @return the nested list that this NestedInteger holds, if it holds a nested list
#        Return None if this NestedInteger holds a single integer
#        :rtype List[NestedInteger]
#        """

class Solution:
    def depthSum(self, nestedList: List[NestedInteger]) -> int:
        
        def dfs(nestedList, d):
            level_sum = 0
            for value in nestedList:
                if value.isInteger():
                    level_sum += value.getInteger() * d
                else:
                    level_sum += dfs(value.getList(), d + 1)
            return level_sum  
        return dfs(nestedList, 1)
```


