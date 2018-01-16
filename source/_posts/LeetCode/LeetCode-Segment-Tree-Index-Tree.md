---
title: LeetCode-Segment-Tree-Index-Tree
date: 2018-01-02 23:47:04
categories: LeetCode-Index
tags:
---

http://zxi.mytechroad.com/blog/sp/fenwick-tree-binary-indexed-tree-sp3/


Update Binary Indexed Tree
Query Binary Indexed Tree

![](http://zxi.mytechroad.com/blog/wp-content/uploads/2018/01/sp3-2.png)

树状数组，首先这是一个数组，但又偏偏通过 2^0, 2^1, 2^2 形式组成了一个树的样子。
为的就是求**区间和**

```java
class FenwickTree {
  int sums_[];
  public FenwickTree(int n) {
    sums_ = new int[n + 1];
  }

  public void update(int i, int delta) {
    while(i < sums_.length) {
      sums_[i] += delta;
      i += i & -i;
    }
  }
  
  public int query(int i) {
    int sum = 0;
    while( i > 0) {
      sum += sums_[i];
      i -= i & -i;
    }
    return sum;
  }
}
```
