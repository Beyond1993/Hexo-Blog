---
title: 0127 Word Ladder
date: 2017-12-26 17:49:59
categories: LeetCode
tags:
---

Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

Only one letter can be changed at a time.
Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
For example,

Given:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log","cog"]
As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
return its length 5.

Note:
Return 0 if there is no such transformation sequence.
All words have the same length.
All words contain only lowercase alphabetic characters.
You may assume no duplicates in the word list.
You may assume beginWord and endWord are non-empty and are not the same.

这题看上去是字符串之间的比较，其实是一个最短路径的问题。




```text
                      +-----+  
        +-------------+ hit +--------------+  
        |             +--+--+              |  
        |                |                 |  
     +--v--+          +--v--+           +--v--+  
     | dit |    +-----+ hot +---+       | hig |  
     +--+--+    |     +-----+   |       +--+--+  
        |       |               |          |  
        |    +--v--+         +--v--+    +--v--+  
        +----> dot |         | lot |    | dig |  
             +--+--+         +--+--+    +--+--+  
                |               |          |  
             +--v--+         +--v--+       |  
        +----> dog |         | log |       |  
        |    +--+--+         +--+--+       |  
        |       |               |          |  
        |       |    +--v--+    |          |  
        |       +--->| cog |<-- +          |  
        |            +-----+               |  
        |                                  |  
        |                                  |  
        +----------------------------------+  
```
