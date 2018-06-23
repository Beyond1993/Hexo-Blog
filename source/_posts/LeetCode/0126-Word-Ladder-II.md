---
title: 0126 Word Ladder II
date: 2017-12-27 22:31:31
categories: LeetCode
tags:
---

Given two words (beginWord and endWord), and a dictionary's word list, find all shortest transformation sequence(s) from beginWord to endWord, such that:

Only one letter can be changed at a time
Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
For example,

Given:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log","cog"]
Return
  [
    ["hit","hot","dot","dog","cog"],
    ["hit","hot","lot","log","cog"]
  ]
Note:
Return an empty list if there is no such transformation sequence.
All words have the same length.
All words contain only lowercase alphabetic characters.
You may assume no duplicates in the word list.
You may assume beginWord and endWord are non-empty and are not the same.


这题要求返回所有的路径，在之前的图论算法中，我们bfs 的同时用一个 iterator path 记录所有值。

这样子只能找到最短路径之一。

所以这里用dfs + level 的方式，找到所有path。

```java
public class Solution {
    private String replace(String word, int i, char c) {
        char[] tmp = word.toCharArray();
        tmp[i] = c;
        return new String(tmp);
    } 
    private ArrayList<String> getNextWords(String word, Set<String> wordList) {
        ArrayList<String> re = new ArrayList<String>();
        int len = word.length();
        for (char c = 'a'; c <= 'z'; c++) {
            for (int i = 0; i < len; i++) {
                if (c == word.charAt(i)) {
                    continue;
                }
                String tmp = replace(word, i, c);
                if (wordList.contains(tmp)) {
                        re.add(tmp);
                    }
                }
            
            }
        return re;
    }
    
    private void bfs(Set<String> wordList, String start, String end, 
                     Map<String, List<String>> graph, Map<String, Integer> level) {
        Queue<String> queue = new LinkedList<String>();
        queue.add(start);
        level.put(start, 0);
        for (String str : wordList) {
            graph.put(str, new ArrayList<String>());
        }
        
        while(!queue.isEmpty()) {
            String cur = queue.poll();
            ArrayList<String> neighbors = getNextWords(cur, wordList);
            
            for (String s : neighbors) {
                graph.get(s).add(cur);
                if (!level.containsKey(s)) {
                    level.put(s, level.get(cur) + 1);
                    queue.offer(s);
                }
            }
        }
        
        
    }
    
    private void dfs(String cur, String end, Map<String, List<String>> graph, 
                     Map<String, Integer> level, List<List<String>> result, List<String> path) {
        path.add(cur);
        if (cur.equals(end)) {
            //result.add(path); ??? 
            result.add(new ArrayList<String>(path));
        } else {
            List<String> neighbors = graph.get(cur);
            for (String next : neighbors) {
                if (level.containsKey(next) && level.get(cur) - 1 == level.get(next)) {
                    dfs(next, end, graph, level, result, path);
                }
            }
        }
        path.remove(path.size() - 1);
    }

    public List<List<String>> findLadders(String beginWord, String endWord, Set<String> wordList) {
        List<List<String> > result = new ArrayList<List<String>>();
        Map<String, Integer> level = new HashMap<String, Integer>();
        Map<String, List<String> > graph = new HashMap<String, List<String>>();
        wordList.add(beginWord);
        wordList.add(endWord);
        List<String> path = new ArrayList<String>();
        bfs(wordList,  endWord, beginWord, graph, level);
        dfs(beginWord, endWord, graph, level, result, path);
        return result;
    }
}
```

two-ends 
```java
 public List<List<String>> findLadders(String start, String end, Set<String> dict) {
    // hash set for both ends
    Set<String> set1 = new HashSet<String>();
    Set<String> set2 = new HashSet<String>();
    
    // initial words in both ends
    set1.add(start);
    set2.add(end);
    
    // we use a map to help construct the final result
    Map<String, List<String>> map = new HashMap<String, List<String>>();
    
    // build the map
    helper(dict, set1, set2, map, false);
    
    List<List<String>> res = new ArrayList<List<String>>();
    List<String> sol = new ArrayList<String>(Arrays.asList(start));
    
    // recursively build the final result
    generateList(start, end, map, sol, res);
    
    return res;
  }
  
  boolean helper(Set<String> dict, Set<String> set1, Set<String> set2, 
                 Map<String, List<String>> map, boolean flip) {
    if (set1.isEmpty()) {
      return false;
    }
    
    if (set1.size() > set2.size()) {
      return helper(dict, set2, set1, map, !flip);
    }
    
    // remove words on current both ends from the dict
    dict.removeAll(set1);
    dict.removeAll(set2);
    
    // as we only need the shortest paths
    // we use a boolean value help early termination
    boolean done = false;
    
    // set for the next level
    Set<String> set = new HashSet<String>();
    
    // for each string in end 1
    for (String str : set1) {
      for (int i = 0; i < str.length(); i++) {
        char[] chars = str.toCharArray();
        
        // change one character for every position
        for (char ch = 'a'; ch <= 'z'; ch++) {
          chars[i] = ch;
          
          String word = new String(chars);
          
          // make sure we construct the tree in the correct direction
          String key = flip ? word : str;
          String val = flip ? str : word;
              
          List<String> list = map.containsKey(key) ? map.get(key) : new ArrayList<String>();
              
          if (set2.contains(word)) {
            done = true;
            
            list.add(val);
            map.put(key, list);
          } 
          
          if (!done && dict.contains(word)) {
            set.add(word);
            
            list.add(val);
            map.put(key, list);
          }
        }
      }
    }
    
    // early terminate if done is true
    return done || helper(dict, set2, set, map, !flip);
  }
  
  void generateList(String start, String end, Map<String, List<String>> map, List<String> sol, List<List<String>> res) {
    if (start.equals(end)) {
      res.add(new ArrayList<String>(sol));
      return;
    }
    
    // need this check in case the diff between start and end happens to be one
    // e.g "a", "c", {"a", "b", "c"}
    if (!map.containsKey(start)) {
      return;
    }
    
    for (String word : map.get(start)) {
      sol.add(word);
      generateList(word, end, map, sol, res);
      sol.remove(sol.size() - 1);
    }
  }
```

这一题和word ladder 是一样的，用map &lt; String, List&lt;String&gt;&gt; 来记录路径，key, 是一个word, List<String> 是bfs 到这个word的路径上的单词。
