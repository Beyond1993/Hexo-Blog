---
title: 0097 Interleaving String
date: 2025-01-14 08:08:28
categories: LeetCode
tags:
---

题目：
S1, S2 字符和S3 匹配，并且 顺序一致

思路:

优先将s1 的字符和 s3 匹配，
如果s1 的匹配不上，就用 s2 的字符和 s3匹配，

如果s1, s2 都和s3 匹配不上，就说明不存在


关键点说明：
s1[i] == s3[i + j]：意味着当前 s1 的字符可以加入结果，并尝试匹配下一个字符。
s2[j] == s3[i + j]：意味着当前 s2 的字符可以加入结果，并尝试匹配下一个字符。
如果 s1[i] 和 s2[j] 都不匹配 s3[i + j]，说明这条路径无法完成交错，递归回溯。

```python
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        if len(s1) + len(s2) != len(s3): return False

        def dfs(i , j):
            if i == len(s1) and j == len(s2):
                return True

            if i < len(s1) and s1[i] == s3[i + j]:
                if dfs(i + 1, j):
                    return True
            if j < len(s2) and s2[j] == s3[i + j]:
                if dfs(i, j + 1):
                    return True
            return False

        return dfs(0,0)
```

memo search

```python
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        if len(s1) + len(s2) != len(s3): return False

        memo = {}
        def dfs(i , j):
            if (i, j) in memo:
                return memo[(i, j)]
            if i == len(s1) and j == len(s2):
                return True

            if i < len(s1) and s1[i] == s3[i + j]:
                if dfs(i + 1, j):
                    memo[(i, j)] = True
                    return True
            if j < len(s2) and s2[j] == s3[i + j]:
                if dfs(i, j + 1):
                    memo[(i, j)] = True
                    return True

            memo[(i, j)] = False
            return False

        return dfs(0,0)
```

