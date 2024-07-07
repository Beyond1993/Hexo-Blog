---
title: 0691-Stickers-to-Spell-Word
date: 2023-12-27 11:25:23
categories: LeetCode
tags:
---

We are given n different types of stickers. Each sticker has a lowercase English word on it.

You would like to spell out the given string target by cutting individual letters from your collection of stickers and rearranging them. You can use each sticker more than once if you want, and you have infinite quantities of each sticker.

Return the minimum number of stickers that you need to spell out target. If the task is impossible, return -1.

Note: In all test cases, all words were chosen randomly from the 1000 most common US English words, and target was chosen as a concatenation of two random words.

 

Example 1:

Input: stickers = ["with","example","science"], target = "thehat"
Output: 3
Explanation:
We can use 2 "with" stickers, and 1 "example" sticker.
After cutting and rearrange the letters of those stickers, we can form the target "thehat".
Also, this is the minimum number of stickers necessary to form the target string.
Example 2:

Input: stickers = ["notice","possible"], target = "basicbasic"
Output: -1
Explanation:
We cannot form the target "basicbasic" from cutting letters from the given stickers.
 

Constraints:

n == stickers.length
1 <= n <= 50
1 <= stickers[i].length <= 10
1 <= target.length <= 15
stickers[i] and target consist of lowercase English letters.


这题还是挺难的，这不是一个sub string 的问题，而是一个计数问题。相当于把stickers 的字符统计出来，并且用最少的stickers 包含target 里所有的字符


这是一个状态压缩DP.  为什么要叫状态压缩呢，是因为需要从所有的status 逐步迭代到最终状态。


举例 "abc" -> 111

a --> 100
b --> 010
c --> 001
ab --> 110
bc --> 011
ac --> 101
abc --> 111



状态转移图:



```txt
         +------------------+ 
         ab   bc---------+  |
         ^     ^         |  |
       /   \ /   \       |  |
      a     b     c      v  v
       \         /        abc
         \    /           ^
           v              |
           ac ------------+
```








1. 一共 2^k 个状态，k 是 target string 长度
2. 通过当前状态 + 第 i 个贴纸 ==> 推导出下一个状态
3. 转移方程 : nums[state'] = min(nums[state'], nums[state] + 1)， +1 表示用了一个贴纸
4. 从小往大转移
5. 填充 getNextState() 函数

