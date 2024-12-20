---
title: 0824 Goat Latin
date: 2024-12-20 11:04:20
categories: LeetCode
tags:
---



```python
class Solution:
    def toGoatLatin(self, sentence: str) -> str:
        words = sentence.split(" ")
        res = ""
        vowel = set("aeiouAEIOU")
        for i in range(len(words)):
            word = words[i]
            if word[0] in vowel:
                word += "ma"
            else:
                word = word[1:] + word[0] + "ma"
            word += "a" * (i + 1) + " "
            res += word
        return res[:-1]
```
