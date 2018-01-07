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

换一种更普通的思路， 这里只有一个index, 用一个index的目的可不是为了节省一个int 变量的空间。而是不再必须用index1 - index2, 或者 index2 - index1
这种好处在 shortest word distance III 中发挥的淋漓尽致.

考虑一个corner case, 
[a,b,c,d,d], 'a', 'd'
expected: 3, result : 1

因为最后两个dd, 是重复的，所以每次 都要 **迭代index, 但只有这次的单词和上次单词不一样** 才计算距离。所以有了条件 !words[index].equals(words[i])

```java
public int shortestDistance(String[] words, String word1, String word2) {
    int index = -1;
    int min = words.length - 1;
    for (int i = 0; i < words.length; i++) {
        if (words[i].equals(word1) || words[i].equals(word2)) {
            if (index != -1 && !words[index].equals(words[i])) {
                min = Math.min(i - index, min);
            }
            index = i;
        }
    }
    return min;
}
```


