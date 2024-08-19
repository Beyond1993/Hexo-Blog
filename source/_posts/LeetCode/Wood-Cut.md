---
title: Wood-Cut
date: 2024-08-19 07:58:33
categories:
tags:
---


描述
有一些原木，现在想把这些木头切割成一些长度相同的小段木头，需要得到的小段的数目至少为 k。给定L和k，你需要计算能够得到的小段木头的最大长度。



木头长度的单位是厘米。原木的长度都是正整数，我们要求切割得到的小段木头的长度也要求是整数。无法切出要求至少 k 段的,则返回 0 即可。

样例
样例 1

输入:
L = [232, 124, 456]
k = 7
输出: 114
说明: 我们可以把它分成 114 的 7 段，而 115 不可以
而且对于 124 这根原木来说多余的部分没用可以舍弃，不需要完整利用
样例 2

输入:
L = [1, 2, 3]
k = 7
输出: 0
说明: 很显然我们不能按照题目要求完成。
挑战
O(n log Len), Len为 n 段原木中最大的长度


```python
def woodCut(self, L, k):
    if not L:
        return 0

    start, end = 1, max(L)
    
    while start + 1 < end:
        mid = (start + end) // 2
        if self.get_pieces(L, mid) >= k:
            start = mid
        else:
            end = mid

    if self.get_pieces(L, end) >= k:
        return end
    
    if self.get_pieces(L, start) >= k:
        return start

    return 0

def get_pieces(self, L, length):
    pieces = 0
    for l in L:
        pieces += l // length
    return pieces
```


