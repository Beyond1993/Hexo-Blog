---
title: 0022 Generate Parentheses
date: 2017-12-31 21:48:29
categories: LeetCode
tags:
---


Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given n = 3, a solution set is:

[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]

```java
public void dfs1(int n, int left, int right, List<String> list, StringBuilder builder) {
  if (builder.length == n * 2) {
    list.add(builder.toString());
    return;
  }

  if (left < n) {
    builder.append("(");
    dfs1(n, left + 1, right, list, builder);
    builder.deleteCharAt(builder.length() - 1);
  }

  if (right < left) {
    builder.append(")");
    dfs1(n, left, right + 1, list, builder);
    builder.deleteCharAt(builder.length() - 1);
  }
  
}
```
