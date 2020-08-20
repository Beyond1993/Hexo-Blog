---
title: 0425 Word Squares
date: 2020-02-26 09:29:48
categories: LeetCode
tags:
---


```java
class Solution {
    
    class TrieNode {
        char val;
        boolean isWord = false;
        TrieNode[] next = new TrieNode[26];
        public TrieNode(char val) {
            this.val = val;
        }
    }
    
    TrieNode root = new TrieNode('-');
    
    public void insert (String word) {
        TrieNode cur = root;
        char c = ' ';
        for (int i = 0; i < word.length(); i++) {
            c = word.charAt(i);
            if (cur.next[c - 'a'] == null) {
                
                TrieNode node = new TrieNode(c);
                cur.next[c - 'a'] = node;
            }
            cur = cur.next[c - 'a'];
        }
        cur.isWord = true;
    }
    
    public List<String> search(String prefix) {
        TrieNode cur = root;
        List<String> res = new ArrayList<String>();
        for (int i = 0; i < prefix.length(); i++) {
            char c = prefix.charAt(i);
            if (cur.next[c - 'a'] != null) {
                cur = cur.next[c - 'a'];
            } else {
                return res;
            }
        }
        
        dfs(cur, res, prefix, "");
        return res;
    }
    
    private void dfs(TrieNode node, List<String> res, String prefix, String temp) {
        if (node.isWord) {
            res.add(prefix.substring(0, prefix.length() - 1) + temp + node.val);
            return;
        }
        
        for (int i = 0; i < 26; i++) {
            if (node.next[i] != null) {
                dfs(node.next[i], res, prefix, temp + node.val);
            }
        }
   }
    
   public List<List<String>> wordSquares(String[] words) {
        List<List<String>> res = new ArrayList<>();
        if (words == null)
            return res;
       
        int len = words[0].length();
        
        for (int i = 0; i < words.length; i++) {
            insert(words[i]);
        }
        
        List<String> list = new ArrayList<>();
        for (String w : words) {
            list.add(w);
            find(len, res, list);
            list.remove(list.size() - 1);
        }

        return res;
    }

    private void find(int len, List<List<String>> res, List<String> list) {
        if (list.size() == len) {
            res.add(new ArrayList<>(list));
            return;
        }

        int index = list.size();
        
        String prefix = "";
        
        for (String s : list)
            prefix += s.charAt(index);
        
        List<String> strings = search(prefix);
        
        for (String s : strings) {
            list.add(s);
            find(len, res, list);
            list.remove(list.size() - 1);
        }
    }
}
```
