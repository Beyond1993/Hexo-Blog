---
title: LeetCode-Segment-Tree-Index-Tree
date: 2018-01-02 23:47:04
categories: LeetCode-Index
tags:
---

http://zxi.mytechroad.com/blog/sp/fenwick-tree-binary-indexed-tree-sp3/

Binary Index Tree 又叫 Fenwick Tree, 是以这个人的名字命名的树结构。

按照Peter M. Fenwick的说法，正如所有的整数都可以表示成2的幂和，我们也可以把一串序列表示成一系列子序列的和。采用这个想法，我们可将一个前缀和划分成多个子序列的和，而划分的方法与数的2的幂和具有极其相似的方式。一方面，子序列的个数是其二进制表示中1的个数，另一方面，子序列代表的f[i]的个数也是2的幂。

摘自 Wiki

其中最重要的点是 划分的方法与数的2的幂和具有及其相似的方式。

比如拿7作为例子，7 =  0111 = 2^2 + 2^1 + 2^0

首先，前7个元素的sum 有三个子序列组成，而且每个子序列里元素的个数，分别是 4, 2, 1。

也就是说
sum[7] = sum[1~4] + sum[5,6] + sum[7]


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
