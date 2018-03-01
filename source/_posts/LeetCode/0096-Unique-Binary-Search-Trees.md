---
title: 0096 Unique Binary Search Trees
date: 2018-02-28 20:57:02
categories: LeetCode
tags:
---

Given n, how many structurally unique BST's (binary search trees) that store values 1...n?

For example,
Given n = 3, there are a total of 5 unique BST's.


```text
   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3
```

```java
public int numTrees(int n) {
  if (n==0) {
     return 1;
  }
  int sum = 0;
  for (int i = 0; i < n ; i++) {
     sum = sum + numTrees(i) * numTrees(n-i-1);  
  }
  return sum;
}
```


catalan number

