---
title: 0077 Combinations
date: 2018-01-25 18:54:37
categories: LeetCode
tags:
---

Given two integers n and k, return all possible combinations of k numbers out of 1 ... n.

For example,
If n = 4 and k = 2, a solution is:

[
  [2,4],
  [3,4],
  [2,3],
  [1,2],
  [1,3],
  [1,4],
]

```java
List<List<Integer>> ans = new LinkedList<List<Integer>>();
    List<Integer> tmp = new LinkedList<Integer>();
    private void dfs(int n, int k, int pos) {
        if (tmp.size() == k) {
            List<Integer> temp = new LinkedList<Integer>(tmp);
            ans.add(temp);    
            return;
        }
        
        for (int i = pos; i <= n; i++) {
            tmp.add(i);
            dfs(n,k, i + 1);
            tmp.remove(tmp.size() - 1);
        }
    }
    
    public List<List<Integer>> combine(int n, int k) {
        dfs(n,k,1);
        return ans;
    }
```

如果是0-1 dfs 那就是2^n

如果是在循环里pick一个那就是n!

比如 n 个里面抽 k 个 combination
应该是 n(n-1)..(n-k), 如果K 足够大，  n(n-1)..k, 优化变成 n(n-1) ... k
C(n,k) = C(n,n - k)

就是 n! / ((n - k) ! * k!)

