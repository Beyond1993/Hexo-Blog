---
title: Big-O-notation
date: 2017-11-25 19:20:28
categories: Algorithm
tags:
---

最近在看MTI关于算法导论的公开课，对于一个超级门外汉，一听到这些记法瞬间就懵了，于是只能求助于谷哥。
（1）Big O
如果存在正数c和N，对于所有的n>=N，有f(n)<=c*g(n)，则f(n)=O(g(n))
是不是很抽象？其实这玩意儿说通俗一点就是求一个算法的worst-case，即是一个最坏情况的度量，求的是上界。
（2）Big Omega
如果存在正数c和N，对于所有的n>=N，有f(n)>=c*g(n)，则f(n)=Omega(g(n))
和Big O相反，这个玩意儿是很乐观的，求得是一个算法的最好情况，即下界，即best-case。不过这玩意儿基本上没什么用，因为你总不能跟用户说我这个算法最快的执行时间是3秒吧？万一一不小心执行了三年，用户岂不要气得吐血？
（3）Big Theta
如果存在正数c1，c2和N，对于所有的n>=N，有c1*g(n)<=f(n)<=c2*g(n)，则f(n)=Theta(g(n))
这个记法表示一个算法不会好于XX，也不会坏于XX，太中庸了，没有激情啊。所以也就是求average-case。
（4）little o
对于任意正数c，均存在正数N，对于所有的n>=N，有f(n)<c*g(n)，则f(n)=o(g(n))
（5）little omega
对于任意正数c，均存在正数N，对于所有的n>=N，有f(n)>c*g(n)，则f(n)=omega(g(n))
好了，就简单介绍到这儿吧，以后有什么再做补充。

大 O , 小 o, 大 omega, 小 omega 区别就是有没有可能相等

[wiki time complexities](https://en.wikipedia.org/wiki/Time_complexity)

![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Comparison_computational_complexity.svg/512px-Comparison_computational_complexity.svg.png)

常见时间复杂度
constant time : O(1)
logarithmic time : O(log n)
linear time : O(n)
quasilinear time : O(nlogn)
quadratic time : O(n^2)
cubic time : O(n^3)
exponential time : O(2^n)
factical time : O(n!)



[LeetCode 46 Permutation] 的时间复杂度是多少？
[LeetCode 77 Combinations] 的时间复杂度是多少？
[LeetCode 78 Subsets] 的时间复杂度是多少？

1. 第一发
permutation, combination, subset 的递归写法分别是多少？

其实subset 的复杂度和 combination 是一样的.

permuation 的核心代码
```java
for (int i = 0; i < nums.length; i++) {
    if (tmp.contains(nums[i])) continue;
    tmp.add(nums[i]);        
    dfs(nums);
    tmp.remove(tmp.size() -1 );
}
```

combination 的核心代码
```java
for (int i = pos; i <= n; i++) {
    tmp.add(i);
    dfs(n,k, i + 1);
    tmp.remove(tmp.size() - 1);
}
```

时间复杂度，N(N-1)(N-2)...(N-k+1)
k = 2 的话只有N (N - 1) 

2^n=C(n,0)+C(n,1)+...+C(n,n).

这样子算 combination 其实是，O( k * C(n, k))


```java
void dfs(int n, int k, int num, int count, List<List<Integer>> ans, 
         List<Integer> path) {
   if (count == k ) {
     ans.add(new ArrayList<Integer>(path));
     return;
   }
   if (num > n) return;
   dfs(n, k, num + 1, conut + 1, ans, path);
   path.add(num);
   dfs(n, k, num + 1, count + 1, ans, path);
   path.remove(path.size() - 1);
}

public List<List<Integer>> combine(int n, int k) {
  List<List<Integer>> ans = new ArrayList<>();
  List<Integer> path = new ArrayList<>();
  dfs(n , k, 1, 0, ans, path);
  return ans;
}
```


先给出答案 permuation 是 O(n!), combination 是 O(2^n)

permutation 是 O(n!) 很明确了, 循环的次数 n * n - 1 * n - 2 * ... 1
所以是 O(n!)

但是 combination 就奇怪了, 明明是一个循环里 dfs 为什么不是阶乘？

O(2 ^ n) 这个时间复杂度，是不是很眼熟，在0 1背包问题的递归解法中，时间复杂度就是O(2 ^ n)

来回顾下那次的代码

```cpp
int n, W
int w[MAX_N], v[MAX_N]
// 从第i个物品开始挑选总重小于j的部分
int rec(int i, int j) {
  int res;
  if (i == n) {
    //已经没有剩余物品了
    res = 0;
  } else if ( j < w[i]) {
    res = res( i + 1, j);
  } else {
    res = max(rec(i + 1, j), rec( i + 1, j - w[i]) + v[i]);
  }
  return res;
}
void solve() {
  printf("%d\n",rec(0, W));
}
```

每一层的搜索需要两个分支，所以就是O(2 ^ n)

经典的计算时间复杂度的公式 O(构造解的复杂度 * 解的个数)
