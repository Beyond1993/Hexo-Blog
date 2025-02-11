---
title: 1347 Minimum Number Of Steps To Make Two Strings Anagram
date: 2025-02-11 13:23:14
categories: LeetCode
tags:
---

至少翻转多少次可以异构，只要计数就行了。

```python
class Solution:
    def minSteps(self, s1: str, s2: str) -> int:
        count = 0
        char_count = [0] * 26  # Array to count occurrences of each character (26 lowercase English letters)

        # Count occurrences of characters in s1
        for char in s1:
            char_count[ord(char) - ord('a')] += 1

        # Compare characters in s2 with the counts from s1
        for char in s2:
            index = ord(char) - ord('a')
            if char_count[index] > 0:
                char_count[index] -= 1  # Reduce the count of the character from s1
            else:
                count += 1  # If no matching character, increment count
        
        return count
```
