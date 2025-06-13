---
title: 0567 Permutation In String
date: 2025-06-13 06:44:08
categories: LeetCode
tags:
---

这题题目意思很明确，就是在S2 里有没有 s1 permutation 的任意一种，肯定是计数来算的。
比较直观的计数，就是在S2 里找到 长度为 len(s1) 的算个计数的map, 比较一下.

```python
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s1) > len(s2):
            return False

        s1_counter = Counter(s1)

        for i in range(len(s2) - len(s1) + 1):
            window = s2[i:i+len(s1)]
            if Counter(window) == s1_counter:
                return True
        return False
```


不用每次都拿substring 去算一个 dict, 可以只用一个dict, sliding window 去计数

```python
from collections import Counter

class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        len1, len2 = len(s1), len(s2)
        if len1 > len2:
            return False

        s1_counter = Counter(s1)
        window_counter = Counter(s2[:len1])

        if window_counter == s1_counter:
            return True

        for i in range(len1, len2):
            char_in = s2[i]
            char_out = s2[i - len1]
            
            # Add new char
            window_counter[char_in] += 1
            # Remove old char
            window_counter[char_out] -= 1

            if window_counter[char_out] == 0:
                del window_counter[char_out]  # 保持 Counter 精简

            if window_counter == s1_counter:
                return True

        return False

```
