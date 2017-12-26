---
title: LeetCode-Union-Find
date: 2017-09-15 22:23:51
categories: LeetCode-Index
tags:
---
Union Findi 的模板
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
 

  private int find(int x) {
    if( father[x]==x ){
       return x;
   }
   return father[x]=find(father[x]);
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



