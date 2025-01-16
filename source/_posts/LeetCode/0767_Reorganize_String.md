---
title: 0767 Reorganize String
date: 2025-01-16 12:22:37
categories: LeetCode
tags:
---


## 题目意思就是问能不能找到一个string, 没有相同相邻的元素
class Solution:
    def reorganizeString(self, s: str) -> str:
        ## 先找到字符最多的，填充偶数位，
        char_counts = Counter(s)
        max_count, letter = 0, ''
        for char, count in char_counts.items():
            if count > max_count:
                max_count = count
                letter = char
        if max_count > (len(s) + 1) // 2:
            return ""
        ans = [''] * len(s)
        index = 0

        # Place the most frequent letter
        while char_counts[letter] != 0:
            ans[index] = letter
            index += 2
            char_counts[letter] -= 1

        # Place rest of the letters in any order
        for char, count in char_counts.items():
            while count > 0:
                if index >= len(s):
                    index = 1
                ans[index] = char
                ## 这里包含了 偶数位没有填充完的情况， 比如 zhmyo
                index += 2
                count -= 1

        return ''.join(ans)
