---
title: CMU-11642-Content
date: 2017-10-27 20:52:57
categories: CMU课程
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
• Information needs & queries 
• Document representation 怎么去选泽要展示的word
• Exact match retrieval
 – Unranked Boolean
 – Ranked Boolean
• Indexing
 – Inverted lists 倒排索引
 – Term dictionary • Query processing
 – TAAT
 – DAAT
• Query operators
