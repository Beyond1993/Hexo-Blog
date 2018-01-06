---
title: 0211 Add and Search Word Data structure design
date: 2018-01-06 18:05:16
categories: LeetCode
tags:
---

Design a data structure that supports the following two operations:

void addWord(word)
bool search(word)
search(word) can search a literal word or a regular expression string containing only letters a-z or .. A . means it can represent any one letter.

For example:

addWord("bad")
addWord("dad")
addWord("mad")
search("pad") -> false
search("bad") -> true
search(".ad") -> true
search("b..") -> true
Note:
You may assume that all words are consist of lowercase letters a-z.

这就是个trie

```java
public class WordDirectinary {
  class TrieNode {
    Map<Character, TrieNode> children;
    boolean isWord;
    public TrieNode() {
      children = new HashMap<Character, TrieNode>();
      isWord = false;
    }
  }      
    TrieNode root = new TrieNode();
    
    public void addWord(String word) {
      TrieNode cur = root;
      for (int i = 0; i < word.length(); i++) {
        if (cur.children.containsKey(word.charAt(i))) {
          cur = cur.children.get(word.charAt(i));
        } else {
          TrieNode node = new TrieNode();
          cur.children.put(word.charAt(i), node);
          cur.node;
        }
      }
      cur.isWord = true;
    }
    
    private boolean dfs(String word, int index, TrieNode cur) {
      if (cur == null) return false;
      if (index == word.length()) return cur.isWord;
      if (word.charAt(index) != '.') {
        return dfs(word, index + 1, cur.children.get(word.chatAt(index)));
      } else {
        for (Map.Entry<Character, TrieNode> e : cur.children.entrySet() {
          if (dfs(word, index + 1, e.getValue())) {
            return true;
          }
        }
      }
    }

    public boolean search(String word) {
      return dfs(word, 0, root);
    }
}
```
