---
title: LeetCode-Union-Find
date: 2017-09-15 22:23:51
categories: LeetCode-Index
tags:
---

https://www.youtube.com/watch?v=VJnUwsE4fWA

https://zxi.mytechroad.com/blog/data-structure/sp1-union-find-set/

Union Find 分为两部分，
第一部分Find 就是找这个节点的根节点。
第二部分Union 就是将两个不连通的模块组合起来。

Disjoint-set/Union-find Forest

Find(x): find the root/cluster-id of x

Union(x, y): merge two clusters

Check whether two elements are in the same set or not in O(1)*.

Find: O(ɑ(n))* ≈ O(1)

Union: O(ɑ(n))* ≈ O(1)

Space: O(n)

Without optimization: Find: O(n)

Two key optimizations:

Path compression: make tree flat
Union by rank: merge low rank tree to high rank one
*: amortized

ɑ(.): inverse Ackermann function


Union Find 的模板
```java
class UnionFind {
  int count = 0;// 多少个联通区域
  int[] father;
  int[] rank;
  unionFind(int n) {
     count = n;
     father = new int[n];
     for (int i = 0; i < n; i++) {
         father[i] = i;
     }
     rank = new int[n];
     rank[i]=1;// rank 在connect里会用到,比如a 和 b 相连，根据rank指定哪个为父节点。
  }
 
  // 递归写法
  private int find(int x) {
    if( father[x]==x ){
       return x;
   }
   return father[x]=find(father[x]);
  }
  // 非递归写法
  public int find(int x) {
    validate(x);
    while (p != parent[p]) {
      parent[p] = parent[parent[p]];    // path compression by halving
      p = parent[p];
    }
    return p;
  }

  public boolean is connect(int a,int b){
    return find(a)==find(b);
  }

  public void connect (int a,int b) {
    int father_a=find(a);
    int father_b=find(b);
    if(father_a!=father_b) {
       father[father,a]=father_b;
       count --;
     }
   }

  public void setCount(int a) {
    count = a;
  }
  
  public int getCount() {
    return count;
  }
}
```

Union Find Class 维护了一个数组，用来存放一个节点的父节点。
对于一个联通块，只有一个根结点。
时间复杂度 O(n)

```python
class UnionFind:
    def __init__(self, n):
        self.count = n
        self.father = list(range(n))
        self.rank = [1] * n

    def find(self, x):
        if self.father[x] != x:
            self.father[x] = self.find(self.father[x])  # Path compression
        return self.father[x]

    def union(self, a, b):
        rootA = self.find(a)
        rootB = self.find(b)
        
        if rootA != rootB:
            if self.rank[rootA] > self.rank[rootB]:
                self.father[rootB] = rootA
            elif self.rank[rootA] < self.rank[rootB]:
                self.father[rootA] = rootB
            else:
                self.father[rootB] = rootA
                self.rank[rootA] += 1
            self.count -= 1

    def connected(self, a, b):
        return self.find(a) == self.find(b)

    def get_count(self):
        return self.count
```

Union-Find Problems:
* LeetCode 399. Evaluate Division https://youtu.be/UwpvInpgFmo
* LeetCode 547. Friend Circles https://youtu.be/HHiHno66j40
* LeetCode 737. Sentence Similarity II https://www.youtube.com/watch?v=0rZUi3kZGLI
* LeetCode 684. Redundant Connection https://www.youtube.com/watch?v=4hJ721ce010
* LeetCode 685. Redundant Connection II https://youtu.be/lnmJT5b4NlM
* LeetCode 839. Similar String Groups  https://zxi.mytechroad.com/blog/string/leetcode-839-similar-string-groups/
* LeetCode 959. Regions Cut By Slashes https://youtu.be/n3s9Q7GtfB4
