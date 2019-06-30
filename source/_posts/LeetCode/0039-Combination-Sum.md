---
title: 0039 Combination Sum
date: 2018-01-09 01:30:27
categories: LeetCode
tags:
---






```java
public class Solution {
    
    private void dfs(int[] candidates, int sum, int target, List<List<Integer>> ans, List<Integer> tmp, int index) {
        if (sum > target) return;
        if (sum == target) {
            ArrayList temp = new ArrayList<Integer>(tmp);
            ans.add(temp);
            return;
        }
        
        for (int i = index; i < candidates.length; i++) {
            tmp.add(candidates[i]);
            dfs(candidates, candidates[i] + sum, target, ans, tmp, i);
            tmp.remove(tmp.size() - 1);
        }
    } 
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> ans = new ArrayList<List<Integer>>();
        List<Integer> tmp = new ArrayList<Integer>();
        dfs (candidates, 0, target, ans, tmp, 0);
        return ans;
    }
}
```
