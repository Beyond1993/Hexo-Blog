---
title: Algorithms-Robert-Sedgewick
date: 2017-12-25 19:19:29
categories: Algorithm
tags:
---

https://algs4.cs.princeton.edu/code/

之前一直是通过leetCode 来学习算法，管中窥豹，总不能提纲挈领.

## 第1章 基础
### 1.1 基础编程模型

### 1.2 数据抽象

### 1.3 背包队列和栈

### 1.4 算法分析

### 1.5 案例研究 ：union-find
我们研究这个问题，主要是为了说明设计和分析算法的基本方法。

这就是为什么Union Find 在面试中如此受欢迎了，想想哪个面试官没有读过这本算法。
#### 1.5.1 动态连通性

相连满足：
自反性： 
对称性：
传递性：
##### 1.5.1.1 网路
大型计算机网路中p和q是否需要架一条新的连接，才能通信，电路之间的触电是否联通，社交网络中的朋友的朋友，我们可能需要处理数百万的对象，和数十亿的连接。
##### 1.5.1.2 变量名等价行
等价的变量名(指向同一对象的多个引用)。垃圾回收机制

##### 1.5.1.3 数学集合
我们要明确一点，Union Find 不是针对图这一数据结构才产生的,这是一种数学集合的思想。
#### 1.5.2 实现
三种不同实现
#### 1.5.2.1 quick-find 算法

```java
public int find(int p) {
  return id[p];
}

public void union(int p, int q)
{
  // 将p和q归并到相同的分量中
  int pID = find(p);
  int qID = find(q);

  // 如果p和q已经在相同的分量之中则不需采取任何行动 
  if (pID == qID) return;
  
  // 将p的分量重命名为q的名称
  for (int i = 0; i < id.length; i++)
    if (id[i] == pID) id[i] = qID;
   
  count--;
}
```
find() 操作速度显然很快，是O(1), 但是 union 是 O(n)

#### 1.5.2.2 quick-find 算法的分析
命题F 在quick-find 算法中，每次 find() 调用只需要访问数组一次，而归并两个分量的union() 操作访问数组的次数在(N + 3) 到 (2N + 1) 之间。

证明: 由代码可知，每次connected() 调用都会检查id[] 数组中的两个元素是否相等，即会调用两次find() 方法。归并两个分量的union()操作会调用两次find(),检查id[] 数组中的全部N个元素并改变它们中1到N - 1个元素的值。

假设我们使用quick-find 算法来解决动态连通性问题并且最后只得到了一个连通分量。那么这至少需要调用
N - 1 次 union(), 又因为每次union() 操作访问数组次数在(N + 3) 到 (2N + 1)之间，即至少(N + 3)(N -1) ~ N^2, 平房级别
#### 1.5.2.3 quick-union 算法

#### 1.5.2.4 森林的表示

#### 1.5.2.5 quick-union 算法的分析
quick-union 最优是linear, 最差是quadratic.
对于某些输入 quick-union 并不比 quick-find 快， 幸亏我们还有第三种实现
```java
private int find(int p)
{
  // 找出分量的名称
  while ( p != id[p]) p = id[p];
  return p;
}

public void union(int p, int q)
{
  // 将p和q的根节点统一
  int pRoot == find(p);
  int qRoot == find(q);
  if (pRoot == qRoot) return;
  
  id[pRoot] = qRoot;

  count--;
}
```
##### 1.5.2.6 加权 quick-union 算法
  在quick-union 的union 中随意将一棵树连接到另一棵树，但是我们加上权重后，总是将较小的树连接到较大的树上。 
  
##### 1.5.2.7 加权quick-union 算法的分析

##### 1.5.2.8 最优算法
要实现路径压缩，只需要为find() 添加一个循环，将在路径上遇到的所有节点都直接链接到根节点。我们所得到的结果几乎是完全扁平化的。

```java
public int find(int p) {
  validate(p);
  while (p != parent[p]) {
      parent[p] = parent[parent[p]];    // path compression by halving
      p = parent[p];
  }
  return p;
}
```

存在N个触点时成本的增长数量级 （最坏情况下）|

|算法|构造函数| union() | find()|
|:---|:-------|:--------|:------|
|quick-find 算法| N | N | 1 |
|quick-union 算法| N | 树的高度 | 树的高度 |
|加权 qiuck-union 算法| N | lgN| lgN |
|使用路径压缩的加权quick-union 算法| N | 非常非常接近但是没达到1（均摊成本) |
|理想情况| N | 1 | 1 | 

#### 1.5.3 展望

## 第2章 排序

## 第3章 查找

## 第4章 图
图论应用在 地图，网页信息，电路，任务调度，商业交易，配对，计算机网络，软件，社交关系

|应用|节点|连接|
|----|:---|:--|
|地图|十字路口|公路|
|网络内容|网页|超链接|
|电路|元器件|导线|
|任务调度|任务|限制条件|
|商业交易|客户|交易|
|配对|学生|申请|
|计算机网络|网络|物理连接|
|软件|方法|调用关系|
|社交网络|人|友谊关系|

学习基本的四张图 **无向图(简单连接)，有向图，加权图，加权有向图**

### 4.1 无向图

含有平行边的称为多重图，没有平行边或者自环的称为简单图，这样就可以用两个点表示一条边

#### 4.1.1 术语表

相邻
子图
度数
路径
环
简单环
联通图
无环图
树
森林
密度，我们研究的几乎都是稀疏图
二分图 两个只能相互比较数组排序

#### 4.1.2 表示无向图的数据类型
##### 4.1.2.1 图的几种表示方法
邻接矩阵， 除了空间问题，还有平行边，
边的数组 边表，前向星，链式前向星
邻接表数组

##### 4.1.2.2 邻接表的数据结构

典型的Graph 实现的性能复杂度

|数据结构|所需空间|添加一条边 v-w | 检查w 和 v是否相邻  | 遍历v的所有相邻点|
|--------|:-----------------------|:--------------------|:-----------------|
|边的列表|E|1|E|E|
|邻接矩阵|V*V|1|1|V|
|邻接表|E + V | 1 | degree(v)| degree(v)|
|邻接集| E + V | logV | logV | logV + degree(v)|

##### 4.1.2.3 图像处理算法的设计模式
典型的应用程序会构造一幅图，将图传递给实现了某个算法的类.
类似于 search(Graph g), 但为什么不用 Graph.search()呢
将邻接表的 Bag 换成 Set 就变成 邻接集了。 

在LeetCode 中，用邻接表表示一张图
```java
class UndirectedGraphNode {
      int label;
      List<UndirectedGraphNode> neighbors;
      UndirectedGraphNode(int x) { 
          label = x; 
          neighbors = new ArrayList<UndirectedGraphNode>(); }
  };
```

#### 4.1.3 深度优先搜索
##### 4.1.3.1 走迷宫
##### 4.1.3.2 热身
##### 4.1.3.3 单向通道
##### 4.1.3.4 跟踪深度优先搜索
##### 4.1.3.5 深度优先搜索的详细轨迹

#### 4.1.4 寻找路径

#### 4.1.5 广度优先搜索

说起 BFS，刷了那么几道题，也是有点感觉了，不过以前是，哦这题要用BFS, BFS 是。。。但是为什么要用BFS?
BFS 最经典的应用就是无权图的最短路径算法了。这个问题的经典方法BFS，他是许多图算法的基石。

```java
public class BreadthFirstPaths
{
  private boolean[] marked;
  private int[] edgeTo;
  private int[] distTo;
  private fina int s;

  public BreadthFirstPaths(Graph G, int s)
  {
    marked = new boolean[G.V()];
    edgeTo = new int[G.V()];
    distTo = new int[G.V()];
    this.s = s;
    bfs(G,s);
  }
  
  private void bfs(Graph G, int s)
  {
    Queue<Integer> queue = new Queue<Integer>();
    for (int v = 0; v < G.V(); v++) {
      distTo[v] = INFINITY;
    }
    distTo[s] = 0;
    mark[s] = true;
    queue.enqueue(s);
    while (!queue.isEmpty())
    {
      int v = queue.dequeue();
      for (int w : G.adj(v)) {
        if (!marked[w]) {
          edgeTo[w] = v; //w 的上一点是 v
          distTo[w] = distTo[v] + 1;
          marked[w] = true;
          queue.enqueue(w);
        }    
      }
    }
  }
  
  public boolean hashPathTo(int v) {
    return marked[v];
  }
  
  public Iterable<Integer> pathTo(int v) {
    if (!hasPathTo(v)) return null;
    Stack<Integer> path = new Stack<Integer>();
    for (int x = v; x != s; x = edgeTo[x]) {
      path.push(x);
    }
    path.push(x);
    return path;
  }
  
  public int distTo(int v) {
    validateVertex(v);
    return distTo[v];
  }
}
```

我们想想这种iterator的方法有什么弊端？ 

那就是它只能找出最短路径之一. 而不能找出所有的最短路径。

所以找所有最短路径的方法就是 dfs, 参考 [Word Ladder II](http://www.wayne.ink/2017/12/27/LeetCode/0126-Word-Ladder-II/)

#### 4.1.6 联通分量

#### 4.1.7 符号图

#### 4.1.8 总结

### 4.2 有向图

#### 4.2.1 术语

#### 4.2.2 有向图的数据类型

#### 4.2.3 有向图中的可达性
#### 4.2.4 环和有向无环图
#### 有向图中的强连通性
#### 4.2.6 总结

### 最小生成树
#### 4.3.1 原理
#### 4.3.2 加权无向图的数据类型
#### 4.3.3 最小生成树的API和测试用例
#### 4.3.4 Prim算法
#### 4.3.5 Prim算法的即使实现
#### 4.3.6 Kruskal算法
#### 4.3.7 展望

### 最短路径
#### 4.4.1 最短路径的性质
#### 4.4.2 加权有向图的数据结构
#### 4.4.3 最短路径算法的理论基础
#### 4.4.4 Dijkstra算法
#### 4.4.5 无环加权有向图中的最短路径算法
#### 4.4.6 一般加权有向图中的最短路径问题
#### 4.4.7 展望



## 第5章 字符串

 


