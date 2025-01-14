---
title: 0055 Jump Game
date: 2019-05-21 23:45:30
categories: LeetCode
tags:
---

Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Determine if you are able to reach the last index.

Example 1:

Input: [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
Example 2:

Input: [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum
             jump length is 0, which makes it impossible to reach the last index.



这段代码之所以有效，是因为它利用了 贪心算法，核心思想是：每一步都尽可能跳得更远，同时实时判断是否能到达目标位置。这种方法可以正确地解决问题的原因主要有以下几点：

1. 问题的本质是“最远能到哪儿”
每个位置 i 上的值 nums[i] 表示你可以从这里最多跳跃的步数。因此，从当前位置出发，下一步的“最远可达位置”是 i + nums[i]。

如果从起点开始一直计算最远可达位置 max_dis，我们可以实时判断是否：

当前的位置 i 是可达的（i <= max_dis）。
最后一个位置是否在 max_dis 的范围内。
通过持续更新 max_dis，我们可以一步步检查是否能到达目标位置。

2. 贪心算法的核心：尽量往最远的地方跳
在每个位置，我们都会更新 max_dis，使其为当前最远能到的位置：

max_dis = max(max_dis, i + nums[i])
这样做的含义是：

在当前位置 i，我们选择一个“最优解”，即从当前位置跳跃后能到的最远位置。
即使后面有很多位置，它们的跳跃能力可能很小，但只要 max_dis 一直能覆盖它们，它们就不需要单独处理。
换句话说，我们只关心全局的最远能到的地方，而不需要纠结于具体的路径。

3. 为什么检查 max_dis < i 是正确的？
如果当前索引 i 超过了 max_dis，就意味着：

max_dis 是目前所有能够到达的最远位置。
但现在的 i 超出了这个范围，也就是说，我们无法跳到位置 i。
因此，这种情况下可以直接返回 False，因为无法继续前进到达终点。

4. 只需考虑一次遍历即可
通过贪心算法，我们能够只遍历一次数组，同时实时更新 max_dis。不需要回溯、不需要递归，因为：

每次更新 max_dis 都是局部最优选择（跳得最远）。
局部最优在这种问题下可以推导出全局最优（能否到达终点）。
一个类比解释
可以将这个问题想象成一个人沿着石头过河：

每块石头的值 nums[i] 表示你站在这块石头上时，最多可以跳多远。
从第 0 块石头开始，计算最远能跳到的石头。
如果能不断地跨越每块石头，直到终点，就说明可以过河；如果某块石头无法到达，就得停下。
为什么贪心是正确的？（证明思路）
假设：

如果从索引 0 能到达索引 i，则可以把 i 视为一个中间点。
如果从索引 i 能到达的最远距离是 max_dis，那么所有 j ∈ [i+1, max_dis] 都可以作为新的起点，继续向后扩展范围。
贪心策略：

每次从当前索引开始，更新最远可达距离 max_dis。如果遍历结束后，max_dis 已经覆盖了最后一个位置，就可以断言：

所有中间点都可达；
最终目标点也可达。
归纳证明：

基础情况：从位置 0 开始，初始 max_dis = 0 是正确的。
假设前 i 步都可以更新最远距离，且 max_dis >= i。
在位置 i，通过更新 max_dis = max(max_dis, i + nums[i])，可以保证下一步的所有点都在可达范围内。
因此，循环结束后，若 max_dis 覆盖了终点位置，整个数组都可达。
总结
这种方法有效的关键在于：

它只关注最远能到的位置（即贪心），而不关心具体的路径。
它能够在一次遍历中判断出是否能到达终点，避免了多余的计算。
通过贪心算法，我们能够以 O(n) 的时间复杂度、高效地解决这个问题。


```python
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        max_dis = 0
        for i in range(len(nums)):
            if max_dis < i:
                return False    
            max_dis = max(max_dis, i+nums[i])
        return True
```

DP solution
```python
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        n = len(nums)
        dp = [False] * n  # 初始化 dp 数组
        dp[0] = True  # 起点总是可以到达的

        for i in range(n):
            if dp[i]:  # 如果当前位置是可达的
                for j in range(1, nums[i] + 1):  # 从当前位置跳到能跳到的所有位置
                    if i + j < n:  # 防止越界
                        dp[i + j] = True
            if dp[-1]:  # 如果最后一个位置已经变成 True，可以提前返回
                return True

        return dp[-1]  # 最后返回最后一个位置是否可达
```


follow up:
http://47.113.101.198/2019/05/21/LeetCode/0045-Jump-Game-II/

