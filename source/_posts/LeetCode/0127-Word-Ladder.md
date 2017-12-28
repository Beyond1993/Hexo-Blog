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


这题经典算法就是 bfs。

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
    
    public int ladderLength(String beginWord, String endWord, Set<String> wordList) {
           if (wordList == null) {
               return 0;
           }
           Queue<String> queue = new LinkedList<String>();
           Set<String> set = new HashSet<String>();
           
           wordList.add(beginWord);
           wordList.add(endWord);
           
           queue.add(beginWord);
           set.add(beginWord);
           
           int length = 1;
           while(!queue.isEmpty()) {
               length++;
               int size = queue.size();
               for (int i = 0; i < size; i++) {
                   
               String cur = queue.poll();
               
               
               for (String str : getNextWords(cur, wordList)) {
                   if (set.contains(str)) {
                       continue;
                   }
                   
                   if (str.equals(endWord)) {
                       return length;
                   }
                   
                   set.add(str);
                   queue.add(str);
               }
            }
           }
           return 0;
    }
}
```

还看到别人的写法，先把图给构造出来，再dfs，也是一种思路。

但是现在面试要求都要最优算法，于是 two-ends bfs 就出现了。

从begin 和 end 开始往中间走，自然快了一倍。

```java
public class Solution {
  public int ladderLength (String beginWord, String endWord, 
                           Set<String> wordList>) {
    Set<String> beginSet = new HashSet<String>();
    Set<String> endSet = new HashSet<String>();
    int len = 1;
    int strLen = beginWord.length();
    HashSet<String> visited = new HashSet<String>();
    
    while(!beginSet.isEmpty() && !endSet.isEmpty()) {
      if (beginSet.size() > endSet.size()) {
         Set<String> set = beginSet;
          beginSet = endSet;
          endSet = set;
      }
      Set<String> temp = new HashSet<String>();
      for (String word : beginSet) {
        char[] chs = word.toCharArray();
        for (int i = 0; i < chs.length; i++) {
          for (char c = 'a'; c <= 'z'; c++) {
            char old = chs[i];
            chs[i] = c;
            String target = String.valueOf(chs);

            if (endSet.contains(target)) {
              return len + 1
            }
            
            if (!visited.contains(target) && wordList.contains(target) {
              temp.add(target);
              visited.add(target);
            }
            chs[i] = old;
          }
        }

      }
      beignSet = temp;
      len++;
    }
    return 0;
  }

}
```

two-end  方法，类似交替bfs, 一旦发现出现了，就return len + 1, 这样子就确保了路径是最短的。
