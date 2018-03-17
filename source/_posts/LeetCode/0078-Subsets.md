---
title: 0078 Subsets
date: 2017-12-23 23:16:48
categories: LeetCode
tags:
---

题目描述：

Given a set of distinct integers, nums, return all possible subsets (the power set).

Note: The solution set must not contain duplicate subsets.

For example,
If nums = [1,2,3], a solution is:

[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]


```java
public class Solution {
    List<List<Integer>> ans = new ArrayList<List<Integer>>();
    List<Integer> tmp = new ArrayList<Integer>();
    private void dfs(int[] nums, int pos) {
        ArrayList temp = new ArrayList<Integer>(tmp);    
        ans.add(temp);
        for (int i = pos; i < nums.length; i++) {
            tmp.add(nums[i]);
            dfs(nums, i + 1);
            tmp.remove(tmp.size() - 1);
        }
    }
    public List<List<Integer>> subsets(int[] nums) {
        dfs(nums, 0);
        return ans;
    }
}
```

因为排列是有顺序的，所以 每次递归里的循环必须从头来。但是组合则不然，选中一个，只能再余下里的选。那有些人可能会问了，求排列的的时候也是这样子的啊。先学院一个，再选下一个，问题就在于[1,2] 我排列可以[1,2], [2,1], 是可以往回选的。组合则不行。所以在排列中 i = 0, 组合中 i = pos.


1. 方法1:
左放，右不放

```text
              {}
            /   \
          a      {}
         / \     /  \   
        ab a{}  a     {}
       / \     / \    / \
     abc ab{} ab  ac ac a  bc 
```

```text
    ""
    "" | "a"
    "" "a" | "b" "ab"
    "" "a" "b" "ab" | "c" "bc" "abc"
```


 
