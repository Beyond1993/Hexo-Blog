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


