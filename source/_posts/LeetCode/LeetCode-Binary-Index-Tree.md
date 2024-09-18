---
title: LeetCode-Binary-Index-Tree
date: 2018-01-02 23:47:04
categories: LeetCode-Index
tags:
---

http://zxi.mytechroad.com/blog/sp/fenwick-tree-binary-indexed-tree-sp3/

Binary Index Tree 又叫 Fenwick Tree, 是以这个人的名字命名的树结构。

我们也可以把一串序列表示成一系列子序列的和。比如典型的segment tree 是均等分的. 区间 [1 ~ 10] 可以分解成 [1 ~ 5], [6 ~ 10], 这样每次更新只要跟新一部分就好了,
但是这种均匀的划分, 树的高度较大，效率不一定对好，想尝试非均匀划分， 比如 按照长度为 1,2,3,4 划分， [1~1], [2 ~ 3], [4~6], [6~10],
或者 长度为 1,3,5,7 [1 ~ 3], [4~9], [10]....

但是这样划分很难找到 区间长度之间的关系, 假如按照1, 2, 3, 4 划分， 如果我要找前7个元素的和, 我知道 [1~1], [2 ~ 3], [4~6], [6~10] 的和分别为 1, 5, 15, 40, 并不能从这四个数找到前7个元素的和 28。

按照Peter M. Fenwick的说法, 所有的整数都可以表示成2的幂和，
采用这个想法，我们可将一个前缀和划分成多个子序列的和，而划分的方法与数的2的幂和具有极其相似的方式。
一方面，子序列的个数是其二进制表示中1的个数，另一方面，子序列里元素的个数也是2的幂。

摘自 Wiki

其中最重要的点是 划分的方法与数的2的幂和具有及其相似的方式。

比如拿7作为例子，7 =  0111 = 2^2 + 2^1 + 2^0

首先，前7个元素的sum 有三个子序列组成，而且每个子序列里元素的个数，分别是 4, 2, 1。

也就是说
sum[7] = sum[1~4] + sum[5,6] + sum[7]

不论前n个元素，n 是几, 总能找到 长度为 2^m .. 2^(m-1) ... 2^0 长度的和


Update Binary Indexed Tree
Query Binary Indexed Tree

![](http://zxi.mytechroad.com/blog/wp-content/uploads/2018/01/sp3-2.png)

树状数组，首先这是一个数组，但又偏偏通过 2^0, 2^1, 2^2 形式组成了一个树的样子。
为的就是求**区间和**

最低位 1: ** x & (-x)**

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

1,2,3,4,5,6,7,8, n = 8

### update
    
i = 1, delta = 1
sum[1] = 1, sum[2] = 1, sum[4] = 1, sum[8] = 1

i = 2, delta = 2

sum[1] = 1, sum[2] = 3, sum[4] = 3, sum[8] = 3

i = 3, delta = 3
11 + 01 = 100, 
sum[1] = 1, sum[2] = 3, sum[3] = 3, sum[4] = 6, sum[8] = 6
   
性质 ：
1. 所有叶子节点 为 1,3,5,7,9,11,奇数数列
2. 因为奇数节点都在偶数区间里，如果更新节点是叶子节点，末位加一是为了找到最近的偶数节点，接下来末位加一就是 偶数节点+2 +4 .. 找到父节点
3. 1 2 4 8 越往后中间间越大 子树越多

### query

sum[7] [1~4] [5,6] [7]



