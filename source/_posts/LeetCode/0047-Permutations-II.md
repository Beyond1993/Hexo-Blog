---
title: 0047 Permutations II
date: 2018-02-01 18:43:49
categories: LeetCode
tags:
---



```java
public List<List<Integer>> permuteUnique(int[] nums) {

    ArrayList<List<Integer>> results = new ArrayList<List<Integer>>();

    if (nums == null || nums.length == 0) {
        return results;
    }

    Arrays.sort(nums);
    ArrayList<Integer> list = new ArrayList<Integer>();
    int[] visited = new int[nums.length];
    for ( int i = 0; i < visited.length; i++){
        visited[i] = 0;
    }

    helper(results, list, visited, nums);    
    return results;
}


public void helper(ArrayList<List<Integer>> results, 
    ArrayList<Integer> list, int[] visited, int[] nums) {

    if(list.size() == nums.length) {
        results.add(new ArrayList<Integer>(list));
        return;
    }

    for(int i = 0; i < nums.length; i++) {
        if ( visited[i] == 1) continue;
        // 前一个相等数如果没有被访问，说明这个数在当前位置已经试过了. 就不需要再试了
        if ( i != 0 && nums[i] == nums[i - 1] && visited[i-1] == 0)){
            continue;
        }

        visited[i] = 1;
        list.add(nums[i]);
        helper(results, list, visited, nums);
        list.remove(list.size() - 1);
        visited[i] = 0;
    }
 } 
```



```python
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        if not nums:
            return nums
        nums.sort()

        res = []
        temp = []
        visited = [False]*len(nums)
        def dfs():
            if len(nums) == len(temp):
                res.append(temp[:])
                return
            
            for i in range(len(nums)):
                ## 第一种情况 这个数字已经用过了
                if visited[i]:
                    continue
                ## 第二种情况，前面的i-1 已经用过了，但是目前这个i 和i-1 一样
                ## 代码比较tricky, 为什么是 i -1 not visited?
                if i > 0 and not visited[i-1] and nums[i-1] == nums[i]:
                    continue
                visited[i] = True
                temp.append(nums[i])
		print(i, temp)
                dfs()
                temp.pop()
                visited[i] = False
        dfs()
        return res
```

not visited, visited 都是可行解.

但是 not visited[i-1] 剪枝更高效


visited[i-1]
```txt
[1]
[1, 2]
[1]
[1, 1]
[1, 1, 2]
[1, 2]
[1, 2, 1]
[2]
[2, 1]
[2, 1]
[2, 1, 1]
```

not visited[i-1]

```txt
[1]
[1, 1]
[1, 1, 2]
[1, 2]
[1, 2, 1]
[2]
[2, 1]
[2, 1, 1]
```

这种题，就是画图，画图. 画back track tree

中间那个树直接整个都跳过了

```txt
          1
     /    |  \
    1     1    2
  /| \   /|\  / |\
 1 1 2  1 1 2 1 1 2
 

```


![](/images/lc_47.jpg)
从图片可以看出，对于第一种  visited[i-1], 发现前面一个已经放过然后跳过，只是剪枝了自己节点下第三层的情况。

对于第二种 not visited[i-1], 相当于把整棵树都剪枝了。

not visited[i-1] 剪枝的点更高
