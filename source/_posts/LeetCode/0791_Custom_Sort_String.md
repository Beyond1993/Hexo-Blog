---
title: 0791 Custom Sort String
date: 2025-01-01 15:50:33
categories: LeetCode
tags:
---

You are given two strings order and s. All the characters of order are unique and were sorted in some custom order previously.

Permute the characters of s so that they match the order that order was sorted. More specifically, if a character x occurs before a character y in order, then x should occur before y in the permuted string.

Return any permutation of s that satisfies this property.

 

Example 1:

Input: order = "cba", s = "abcd"

Output: "cbad"

Explanation: "a", "b", "c" appear in order, so the order of "a", "b", "c" should be "c", "b", and "a".

Since "d" does not appear in order, it can be at any position in the returned string. "dcba", "cdba", "cbda" are also valid outputs.

Example 2:

Input: order = "bcafg", s = "abcd"

Output: "bcad"

Explanation: The characters "b", "c", and "a" from order dictate the order for the characters in s. The character "d" in s does not appear in order, so its position is flexible.

Following the order of appearance in order, "b", "c", and "a" from s should be arranged as "b", "c", "a". "d" can be placed at any position since it's not in order. The output "bcad" correctly follows this rule. Other arrangements like "dbca" or "bcda" would also be valid, as long as "b", "c", "a" maintain their order.

 

Constraints:

1 <= order.length <= 26
1 <= s.length <= 200
order and s consist of lowercase English letters.
All the characters of order are unique.


第一种方法就是自己实现一个comparator

遍历result list, 如果 s_char 在order 里，就去取 order 里 s_char 的index, 如果不在就返回 len(order)

```python
class Solution:
    def customSortString(self, order: str, s: str) -> str:
        # Create a list of characters from the string s
        result = list(s)
        
        # Sort using the custom order
        result.sort(key=lambda s_char: order.index(s_char) if s_char in order else len(order))
        
        # Return the sorted result as a string
        return ''.join(result)
```
n is length of s, m is length of order
time: complexity is O(n * m + n log n).

better with map:
```python
class Solution:
    def customSortString(self, order: str, s: str) -> str:
        # Create a list of characters from the string s
        result = list(s)
        
        # Sort using the custom order
        result.sort(key=lambda s_char: order.index(s_char) if s_char in order else len(order))
        
        # Return the sorted result as a string
        return ''.join(result)
```

time (n log n + m)


count 计数 可以 O（N）

```python
class Solution:
    def customSortString(self, order: str, s: str) -> str:
        
        freq = {}
        ## 先统计 s 的字符数量
        for c in s:
            freq[c] = freq.get(c, 0) + 1
        res = ""

        ## 计算 order 里的字符
        for c in order:
            if c in freq:
                while freq[c] > 0:
                    res += c
                    freq[c] -= 1
        
        ## 计算 order 里有， s 里没有的字符
        for c in freq.keys():
            while freq[c] > 0:
                res += c
                freq[c] -= 1

        return res
```

best
```python
class Solution:
    def customSortString(self, order: str, s: str) -> str:
        # Step 1: Count the frequency of each character in `s`
        freq = {}
        for c in s:
            freq[c] = freq.get(c, 0) + 1
        
        # Step 2: Build the result string based on the custom order
        res = ""
        
        # Add characters from `order` in the required frequency
        for c in order:
            if c in freq:
                res += c * freq[c]  # Add the character `c` `freq[c]` times
                freq[c] = 0  # All instances of this character have been processed
        
        # Step 3: Add remaining characters from `s` that are not in `order`
        for c, count in freq.items():
            if count > 0:
                res += c * count  # Append the remaining characters

        return res
```

                

            


