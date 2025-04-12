---
title: 2049 Count Nodes With The Highest Score
date: 2025-04-12 08:20:51
categories: LeetCode
tags:
---


这题的题目意思， 算一个点的score, score = 去除这个点之后, 剩下的部分size 的乘积.

剩下的部分其实就是三部分，左子树，右子树， parent 子树


```python
class Solution:
    def countHighestScoreNodes(self, parents: List[int]) -> int:
        from collections import defaultdict, Counter
        
        tree = defaultdict(list)
        for child, parent in enumerate(parents):  # build the tree
            tree[parent].append(child)
        
        total_nodes = len(parents)
        score_counter = Counter()
        
        def dfs(node: int) -> int:
            product = 1
            subtree_size_sum = 0
            
            for child in tree[node]:
                ## 先算出所有的 子树的 size
                child_subtree_size = dfs(child)
                ## 子树size 相加，为了后面计算 parent size
                subtree_size_sum += child_subtree_size
                ## 算乘积
                product *= child_subtree_size
                
            
            remaining_size = total_nodes - 1 - subtree_size_sum
            product *= max(1, remaining_size)  # avoid multiplying by 0
            score_counter[product] += 1
            
            return subtree_size_sum + 1  # include current node
        
        dfs(0)  # start DFS from root
        return score_counter[max(score_counter)]
```

