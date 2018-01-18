---
title: Graph Search
date: 2017-12-26 05:36:03
categories: Algorithm
tags:
---

掌握图的遍历, DFS, BFS
图的遍历一般指遍历点， 遍历边是有向图遍历点的特殊形式．

遍历点: DFS
递归: 设置一个visited数组
非递归:

遍历点: BFS
递归: 已经visited 过的就不需要重新加入queue了
非递归:

有向图的遍历:将有出度就加入HashMap 作为 key, 将其邻接表存入 queue, list
这样一个节点有几个入读，就会出现几次
每遍历一次就会从相应队列里删除一个

BFS 求最短路径只是针对无向图

图的BFS 类似于树，出队一个节点，将neighbor 入队，　用set标记是否已经访问过．但为
了能找出层次，先用size来　for 循环．

这是存边的情况

```cpp
#include<iostream>
#include<fstream>
#include<queue>
#include<stack>
using namespace std;
#define MAX 10
typedef struct graph
{
  int n;   //顶点数
  int e;  //边数
  int edge[MAX][MAX];  //标识边，0为没有该边，不为0则有边，且标识边的权值
}Graph;
int visit[MAX] = { 0 };    //表示该顶点有没有访问过，没有为0，有为1

void InitGraph(Graph *G)
{
  for (int i = 0; i < MAX;i++)
  for (int j = 0; j < MAX; j++)
    (*G).edge[i][j] = 0;
}

//广度优先搜索算法
void BFS(Graph G, int num)  //num为从该点开始进行搜索
{
  queue<int>Queue;
  cout << num <<" ";   
  visit[num] = 1;
  Queue.push(num);  //访问完该点后入队列
  while (!Queue.empty())  //队列不为空时
  {
    num = Queue.front();  //出队
    Queue.pop();
    for (int i = 0; i < G.n; i++)
    {
      if (G.edge[num][i] != 0 && visit[i] == 0)   //找到与之相连的顶点入队
      {
        cout << i << " ";
        Queue.push(i);
        visit[i] = 1;
      }
    }
  }
  cout << endl;
}

void DFS1(Graph G, int num) //深度优先搜索递归算法
{
  int i;
  cout << num << " ";
  visit[num] = 1;
  for (i = 0; i < G.n; i++)
  {
    if (G.edge[num][i] != 0 && visit[i] == 0)
      DFS1(G, i);
  }
}
void DFS2(Graph G, int num) //深度优先搜索非递归算法
{
  stack<int> Stack;
  visit[num] = 1;
  Stack.push(num);
  while (!Stack.empty())
  {
    num = Stack.top();
    Stack.pop();
    cout << num << " ";
    for (int i = G.n - 1; i >= 0; i--)
    {
      if (G.edge[num][i] != 0 && visit[i] == 0)
      {
        Stack.push(i);
        visit[i] = 1;
      }
    }
  }
  cout << endl;
}
int main()
{
  int a, b, v, i;
  Graph G;
  ifstream cin("data.txt");
  cin >> G.n >> G.e;   //n,e为顶点个数，边个数
  InitGraph(&G);   //对G进行初始化，整个MAX范围初始化
  for (i = 0; i < G.e; i++)   //建图
  {
    cin >> a >> b >> v;  //a,b为顶点，v为权值
    G.edge[a][b] = v;
    G.edge[b][a] = v;
  }
  BFS(G, 0); //0为开始搜索的顶点序号
  for (i = 0; i < MAX; i++)
    visit[i] = 0;
  DFS1(G, 0);
  cout << endl;
  for (i = 0; i < MAX; i++)
    visit[i] = 0;
  DFS2(G, 0);
  system("pause");
  return 0;
}
```

```text
8 9
0 1 1
0 2 1
1 3 1
1 4 1
2 5 1
2 6 1
3 7 1
4 7 1
5 6 1
```
对于经典的邻接矩阵

BFS 
```java
```

DFS 
```java

```


