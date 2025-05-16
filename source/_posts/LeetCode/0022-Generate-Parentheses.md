---
title: 0022 Generate Parentheses
date: 2017-12-31 21:48:29
categories: LeetCode
tags:
---


Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given n = 3, a solution set is:

[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]

```java
public void dfs1(int n, int left, int right, List<String> list, StringBuilder builder) {
  if (builder.length == n * 2) {
    list.add(builder.toString());
    return;
  }

  if (left < n) {
    builder.append("(");
    dfs1(n, left + 1, right, list, builder);
    builder.deleteCharAt(builder.length() - 1);
  }

  if (right < left) {
    builder.append(")");
    dfs1(n, left, right + 1, list, builder);
    builder.deleteCharAt(builder.length() - 1);
  }
  
}
```

```python
class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        res = []
        def dfs(n, left, right, path):
            if len(path) == n * 2:
                res.append("".join(path))
            
            if left < n:
                path.append('(')
                dfs(n, left + 1, right, path)
                # 这行不是回溯！它只是给局部变量 path 赋了一个新列表的引用，但原始列表没变。
                # path = path[:-1]
                path.pop()
            
            if right < left:
                path.append(')')
                dfs(n, left, right + 1, path)
                path.pop()
            
        dfs(n, 0, 0, [])
        return res
```
