---
title: 692 Top K Frequent Words
date: 2024-10-07 07:40:26
categories: LeetCode
tags:
---
找出前k 个出现次数最多的单词。

Example 1:

Input: words = ["i","love","leetcode","i","love","coding"], k = 2
Output: ["i","love"]
Explanation: "i" and "love" are the two most frequent words.
Note that "i" comes before "love" due to a lower alphabetical order.
Example 2:

Input: words = ["the","day","is","sunny","the","the","the","sunny","is","is"], k = 4
Output: ["the","is","sunny","day"]
Explanation: "the", "is", "sunny" and "day" are the four most frequent words, with the number of occurrence being 4, 3, 2 and 1 respectively.

required time complexity O(N log K)

```python
class Comparator:

    def __init__(self, word: str, freq: int):
        self.word = word
        self.freq = freq

    def __gt__(self, other):
        if self.freq == other.freq:
            return self.word < other.word
        return self.freq > other.freq

class Solution:
    def topKFrequent(self, words: List[str], k: int) -> List[str]:
        res = []
        heap = []

        for word, freq in collections.Counter(words).items():
            heapq.heappush(heap, Comparator(word, freq))
            if len(heap) > k:
                heapq.heappop(heap)
        
        while heap:
            res.append(heapq.heappop(heap).word)
        
        return res[::-1]
```



