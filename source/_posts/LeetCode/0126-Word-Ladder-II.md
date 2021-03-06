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
public class Solution {
    int l;
    boolean isConnected;
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        List<List<String>>res = new ArrayList<>();
        if(!wordList.contains(endWord))
            return res;
        l = beginWord.length();
        Set<String>begin = new HashSet<>();
        begin.add(beginWord);
        Set<String>end = new HashSet<>();
        end.add(endWord);
        Map<String, List<String>>map = new HashMap<>();
        Set<String>wordSet = new HashSet<>(wordList);
        bfs(begin, end, wordSet, map, false);
        if(!isConnected)
            return res;
        List<String>list = new ArrayList<>();
        list.add(beginWord);
        dfs(res, list, endWord, beginWord, map);
        return res;
    }

    private void bfs(Set<String>begin, Set<String>end, Set<String>wordSet,  Map<String, List<String>>map, boolean swap){
        if(begin.isEmpty()||end.isEmpty())
            return;
        if(begin.size()>end.size()){
            bfs(end, begin, wordSet, map, !swap);
            return;
        }
        wordSet.removeAll(begin);
        wordSet.removeAll(end);
        Set<String>set = new HashSet<>();
        for(String s: begin){
            for(int i=0; i<l; i++){
                char[]ary = s.toCharArray();
                for(char c = 'a'; c<='z'; c++){
                    ary[i] = c;
                    String word = String.valueOf(ary);
                    if(!end.contains(word)&&!wordSet.contains(word))
                        continue;
                    String key = !swap?s:word;
                    String val = !swap?word:s;
                    if(!map.containsKey(key)){
                        map.put(key, new ArrayList<>());
                    }
                    map.get(key).add(val);
                    if(end.contains(word)){
                        isConnected = true;

                    }
                    if(wordSet.contains(word)){
                        set.add(word);
                    }
                }
            }
        }
        if(!isConnected){

            bfs(set, end, wordSet, map, swap);
        }
    }

    private void dfs(List<List<String>>res, List<String>list,String endWord, String word, Map<String, List<String>>map){
        if(word.equals(endWord)){
            res.add(new ArrayList<>(list));
            return;
        }
        if(!map.containsKey(word))
            return;
        for(String neighbor: map.get(word)){
            list.add(neighbor);
            dfs(res, list, endWord, neighbor, map);
            list.remove(list.size()-1);
        }
    }
}
```

这一题和word ladder 是一样的，用map &lt; String, List&lt;String&gt;&gt; 来记录路径，key, 是一个word, List<String> 是bfs 到这个word的路径上的单词。


新的代码:

```java
class Solution {
    public List<List<String>> findLadders(String start, String end, List<String> wordList) {
   HashSet<String> dict = new HashSet<String>(wordList);
   List<List<String>> res = new ArrayList<List<String>>();         
   HashMap<String, ArrayList<String>> nodeNeighbors = new HashMap<String, ArrayList<String>>();// Neighbors for every node
   HashMap<String, Integer> distance = new HashMap<String, Integer>();// Distance of every node from the start node
   ArrayList<String> path = new ArrayList<String>();

   dict.add(start);          
   bfs(start, end, dict, nodeNeighbors, distance);                 
   dfs(start, end, dict, nodeNeighbors, distance, path, res);   
   return res;
}

// BFS: Trace every node's distance from the start node (level by level).
private void bfs(String start, String end, Set<String> dict, HashMap<String, ArrayList<String>> nodeNeighbors, HashMap<String, Integer> distance) {
  for (String str : dict)
      nodeNeighbors.put(str, new ArrayList<String>());

  Queue<String> queue = new LinkedList<String>();
  queue.offer(start);
  distance.put(start, 0);

  while (!queue.isEmpty()) {
      int count = queue.size();
      boolean foundEnd = false;
      for (int i = 0; i < count; i++) {
          String cur = queue.poll();
          int curDistance = distance.get(cur);                
          ArrayList<String> neighbors = getNeighbors(cur, dict);

          for (String neighbor : neighbors) {
              nodeNeighbors.get(cur).add(neighbor);
              if (!distance.containsKey(neighbor)) {// Check if visited
                  distance.put(neighbor, curDistance + 1);
                  if (end.equals(neighbor))// Found the shortest path
                      foundEnd = true;
                  else
                      queue.offer(neighbor);
                  }
              }
          }

          if (foundEnd)
              break;
      }
  }

// Find all next level nodes.    
    private ArrayList<String> getNeighbors(String node, Set<String> dict) {
  ArrayList<String> res = new ArrayList<String>();
  char chs[] = node.toCharArray();

  for (char ch ='a'; ch <= 'z'; ch++) {
      for (int i = 0; i < chs.length; i++) {
          if (chs[i] == ch) continue;
          char old_ch = chs[i];
          chs[i] = ch;
          if (dict.contains(String.valueOf(chs))) {
              res.add(String.valueOf(chs));
          }
          chs[i] = old_ch;
      }

  }
  return res;
}

// DFS: output all paths with the shortest distance.
    private void dfs(String cur, String end, Set<String> dict, HashMap<String, ArrayList<String>> nodeNeighbors, HashMap<String, Integer> distance, ArrayList<String> path, List<List<String>> res) {
        path.add(cur);
        if (end.equals(cur)) {
           res.add(new ArrayList<String>(path));
        } else {
           for (String next : nodeNeighbors.get(cur)) {            
                if (distance.get(next) == distance.get(cur) + 1) {
                     dfs(next, end, dict, nodeNeighbors, distance, path, res);
                }
            }
        }           
       path.remove(path.size() - 1);
    }
}
```

注意事项：

1. 剪枝
2. path 的增加和删减都是 在 for 循环之外的，否则 会出现 [cog, dog, log]

这类情况
