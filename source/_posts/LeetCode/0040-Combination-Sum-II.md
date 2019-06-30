---
title: 0040 Combination Sum II
date: 2018-02-18 03:08:40
categories: LeetCode
tags:
---

```java
public class Solution {
    public List<List<Integer>> combinationSum2(int[] visited, int target) {
        Arrays.sort(visited);
        List<List<Integer>> res = new ArrayList<List<Integer>>();
        List<Integer> path = new ArrayList<Integer>();
        dfs_com(visited, 0, target, path, res);
        return res;
    }
    void dfs_com(int[] visited, int cur, int target, List<Integer> path, List<List<Integer>> res) {
        if (target == 0) {
            res.add(new ArrayList(path));
            return ;
        }
        if (target < 0) return;
        for (int i = cur; i < visited.length; i++){
            if (i > cur && visited[i] == visited[i-1]) continue;
            path.add(path.size(), visited[i]);
            dfs_com(visited, i+1, target - visited[i], path, res);
            path.remove(path.size()-1);
        }
    }
}
```
