---
title: CMU-11642-Content
date: 2017-10-27 20:52:57
categories: CMU
tags:
---

01-CourseIntro

The bag of words model (feature vector)

Heap's Law

Zipf's Law

Overview of Course Topics
• Web crawling
• Text representation
• Search engine indexes
• Index construction
• Query structure
• Unsupervised ranking
• Feature-based ranking
• Federated & vertical search
• Page features
• Evaluation
• Search log analysis • Diversity
• Personalization
• Context
• Enterprise search

Assignments
• Implement two unranked Boolean retrieval algorithms 
• Implement two popular document ranking algorithms 
• Implement pseudo relevance feedback
• Implement features and test learning to rank (LeToR) 
• Implement diversified ranking algorithms

Introduction to Shallow Language Processing

为什么是shallow, 区别于NLP, 不用考虑语义上的意义。

Two "law" describe how words are used in human languages
Statistical Prperties of Text
Heaps's Law: The size of the vocabulary
Zipf's Law: The term frequency distribution

用不同的law 计算。

语言统计学三大定律：
Zipf law，Heaps law和Benford law

zipf law：在给定的语料中，对于任意一个term，其频度(freq)的排名（rank）和freq的乘积大致是一个常数。
Heaps law：在给定的语料中，其独立的term数（vocabulary的size）v（n）大致是语料大小（n）的一个指数函数。
Benford law：在自然形成的十进制数据中，任何一个数据的第一个数字d出现的概率大致log10(1+1/d)
 
其中Benford law还在会计作假帐的审查和政治选票合法性审查起到了重要作用。


exact-match 的不足:

02-IntroToSearch

• Ad-hoc retrieval
对于搜索广告, 我就不说啥了。

• Information needs & queries 
Query Trees:
• Leaves are index terms
• Leaves are pointers to inverted lists stored on disk ?

```text
      AND             |
    /     \           | Memory
   OR       \         |
  /   \       \       |
great terrific camera 
  |     |        |    |
  V     V        V    |
  .     .        .    |Disk
  .     .        .    |
  .     .        .    |
```


• Document representation 怎么去选泽要展示的word
  • Free-text indexing: use some of words
  • Full-text indexing: use most of words

  • The Binary Full-Text Representation: 给所有单词建表，Doc(i) 包含这个单词，则value is 1. position and frequency are ignored

  bag of words, 简单有效，在 search classification 任务中表现良好。

  Frequence Based Full-Text Representation

  Binary Full-Text Representation value 从 0， 1 变成 frequence

  More effective for search than the binary representation

• Exact match retrieval
 – Unranked Boolean
Documents are returned in no particular order

 – Ranked Boolean
既然要rank, 那这个rank的score 是怎么计算的呢？

AND 操作怎么算， OR 操作怎么算 。。。。

优点 简单有效
缺点 still a Exact-Math, it is difficult to get a good balance of Precision and Recall


• Indexing
 – Inverted Lists 倒排列表，一步一步优化, Inverted Lists, query --> list&lt;docid&gt;
 – Term dictionary 就是一个缓存

• Query processing
 – TAAT Term-at-a-Time
 – DAAT Document-at-a-Time
 – TAAT / DAAT hybrids

• Query operators

在搜索引擎和信息检索领域中，针对词组查询主要有TAAT策略，和DAAT策略两种经典的索引结构查询遍历算法
TAAT策略每次只选择一个查询词项对应的倒排链对其进行完整的遍历，
http://www.docin.com/p-1643110232.html

http://www.360doc.com/content/13/0201/09/1200324_263539380.shtml
