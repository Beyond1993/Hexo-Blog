---
title: 0046 Permutations
date: 2017-12-21 21:02:08
categories: LeetCode
tags:
---

这题的递归写法

```java
List<List<Integer>> ans = new LinkedList<List<Integer>>();
List<Integer> tmp = new LinkedList<Integer>();
private void dfs(int[] nums) {
    if (tmp.size() == nums.length) {
        ans.add(new LinkedList(tmp));
        return;
    }

    for (int i = 0; i < nums.length; i++) {
        if (tmp.contains(nums[i])) continue;
        tmp.add(nums[i]);

        dfs(nums);
        tmp.remove(tmp.size() -1 );
    }
}
public List<List<Integer>> permute(int[] nums) {
    dfs(nums);
    return ans;
}
```

这题的递归写法，


```java
List<List<Integer>> ans = new LinkedList<List<Integer>>();
private void dfs(int[] nums, List<Integer> tmp) {
    if (tmp.size() == nums.length) {
        ans.add(new LinkedList(tmp));
        return;
    }

    for (int i = 0; i < nums.length; i++) {
        if (tmp.contains(nums[i])) continue;
        tmp.add(nums[i]);
        dfs(nums, tmp);
    }
}

public List<List<Integer>> permute(int[] nums) {
    List<Integer> tmp = new LinkedList<Integer>();
    dfs(nums, tmp);
    return ans;
}
```

我之前在想能不能用, 递归自身的性质，来调节tmp的变量.


```python
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        ans = []
        temp = []

        def dfs():
            if len(nums) == len(temp):
                ans.append(temp[:])
                return
            
            for i in range(len(nums)):
                if nums[i] in temp:
                    continue
                temp.append(nums[i])
                dfs()
                temp.pop()
        dfs()
        return ans

```

```python
    def permute(self, nums: List[int]) -> List[List[int]]:
        self.res = []
        self.temp = []
        self.dfs(nums)
        return self.res

    def dfs(self, nums: List[int]):
        if len(nums) == len(self.temp):
            self.res.append(self.temp[:])
        
        for i in nums:
            if i in self.temp:
                continue
            self.temp.append(i)
            self.dfs(nums)
            self.temp.pop()
        
```

