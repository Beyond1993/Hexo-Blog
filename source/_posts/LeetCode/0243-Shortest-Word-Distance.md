---
title: 0243 Shortest Word Distance
date: 2018-01-07 02:21:26
categories: LeetCode
tags:
---

Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.

For example,
Assume that words = ["practice", "makes", "perfect", "coding", "makes"].

Given word1 = “coding”, word2 = “practice”, return 3.
Given word1 = "makes", word2 = "coding", return 1.

Note:
You may assume that word1 does not equal to word2, and word1 and word2 are both in the list.

这题我们来讲面试题背后的故事，我们在machine learning 的领域里面, 在 word2vec里，我们用滑窗来计算每个词related word 出现的次数，但是我们能不能在我们的训练集里面找到任意两个词之间的最短的距离，作为一个feature, 或者我们提供一个service, 返回一个数据集里的两个词之间最短距离。

我们现在考虑最简单的情况。word1 和 word2 没有重复。
这里我们用两个index 做标记，

```java
public int shortestDistance(String[] words, String word1, String word2) {
    int index1 = -1, index2 = -1, min = Integer.MAX_VALUE;
    for (int i = 0; i < words.length; i++) {
        if (words[i].equals(word1)) {
            index1 = i;
        }

        if (words[i].equals(word2)) {
            index2 = i;
        }
        if (index1 != -1 && index2 != -1)
        min = Math.min(min, Math.abs(index1 - index2));
    }
    return min;
}
```


