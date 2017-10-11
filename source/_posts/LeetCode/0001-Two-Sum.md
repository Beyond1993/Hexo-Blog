---
title: 1-Two-Sum
date: 2017-09-99 23:00:54
categories: LeetCode
tags:
---

Two-Sum 

也算是算法入门的hello word了。2-sum 可以拓展到 3-sum, 4-sum 一直到 n-sum
而且这道题除了N-sum本身，更多的是揭示算法的优化过程.

从暴力解法,一般是O(n^2) 到 O(nlogn) 到 O(n) 的优化，更是延伸到follow up. 装不进内存怎么半，输入是一个流怎么半？ 分布式。多台机器情况下怎么办？/

题目描述：
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].


解法一：暴力解法. O(n^2)
```java
public int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[j] == target - nums[i]) {
                return new int[] { i, j };
            }
        }
    }
    throw new IllegalArgumentException("No two sum solution");
}
```
在面试中，第一步需要想到的，就是暴力解法，这样子，起码有一个解。
而在brute force中，又有一个优先级，for loop --> dfs ---> backtracking --> permulation.
所以说，就算你要用brute force, 也要从 for loop开始想起， 而不是 递归， 回溯.

解法二：O(nlogn)

这是常见的优化，一般工作中算法优化到这就可以运行了，常见方法。

排序，
二分，
各种树，
堆，
区间最大值. 

解法三：O(n) 利用HashMap, LRU 优化算法。达到O(n) 
constanet variable
HashMap 
LRU

解法四: O(n) 优化空间复杂度。

Follow UP:


