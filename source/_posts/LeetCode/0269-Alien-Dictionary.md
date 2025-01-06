---
title: 0269 Alien Dictionary
date: 2017-12-26 06:20:08
categories: LeetCode
tags:
---

这题的意思是

给出一个string list, 然后反推出 这个list 的字典序， 返回任意一个可行解即可

其实这题的思路很 直观，先构造拓扑数据，然后再进行拓扑排序


构造拓扑的边，并且算出in_degree

```python
class Solution:
    def alienOrder(self, words: List[str]) -> str:
        adj_list = {}  # adjacency list for graph
        in_degree = {} # to track the in-degree (number of dependencies) of each letter

        # Initialize graph with all letters and set their in-degree to 0
        for word in words:
            for c in word:
                in_degree[c] = 0  # Initialize in-degree to 0 for every character
                adj_list[c] = []   # Initialize the adjacency list for each character

        # Step 1: Find all edges (dependencies between characters).
        for i in range(len(words) - 1):
            word1, word2 = words[i], words[i + 1]
            # Check if word2 is a prefix of word1 and if word1 is longer, it's an invalid case.
            if len(word1) > len(word2) and word1.startswith(word2):
                return ""

            # Find the first non-matching characters and build the graph.
            for j in range(min(len(word1), len(word2))):
                if word1[j] != word2[j]:
                    adj_list[word1[j]].append(word2[j])  # word1[j] should come before word2[j]
                    in_degree[word2[j]] += 1  # Increment the in-degree for word2[j]
                    break

        # Step 2: Topological Sort using BFS (Kahn's Algorithm)
        queue = deque([c for c in in_degree if in_degree[c] == 0])  # nodes with no dependencies (in-degree 0)
        result = []

        while queue:
            c = queue.popleft()
            result.append(c)
            for next_char in adj_list[c]:
                in_degree[next_char] -= 1  # Decrease the in-degree for the next character
                if in_degree[next_char] == 0:
                    queue.append(next_char)

        # If the result length is less than the number of unique letters, there's a cycle.
        if len(result) < len(in_degree):
            return ""
        
        return ''.join(result)
```
