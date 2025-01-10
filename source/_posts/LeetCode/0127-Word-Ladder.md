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

Time Complexity - O(n * 26 ^ L)  虽然26 ^ L 就可以找到最后的单词了，但这是一个路径. 


the basic solution
 
```python
class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        if endWord not in wordList:
            return 0 
        

        def getNeighbors(word, wortList):
            
            res = []

            for word2 in wordList:
                if len(word) != len(word2):
                    continue
                diff = 0
                for i in range(len(word2)):
                    if word[i] != word2[i]:
                        diff += 1
                if diff == 1: 
                    res.append(word2)
            return res

        q = collections.deque()
        q.append((beginWord, 1))
        visited = set()
        visited.add(beginWord)

        while q: 
            cur, step = q.popleft()
            neighbors = getNeighbors(cur, wordList)
            for neighbor in neighbors:
                if neighbor == endWord: 
                    return step + 1
                if neighbor not in visited:
                    visited.add(neighbor)
                    q.append((neighbor, step + 1))
        return 0
```

precompute the get neighbors:

```python
class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        if endWord not in wordList:
            return 0 
        
        def getNeighbors(word, wortList):
            res = []
            for word2 in wordList:
                if len(word) != len(word2):
                    continue
                diff = 0
                for i in range(len(word2)):
                    if word[i] != word2[i]:
                        diff += 1
                if diff == 1: 
                    res.append(word2)
            return res

        neighborsMap = {}
        allowWords = wordList + [beginWord]
        for word in allowWords:
            neighborsMap[word] = getNeighbors(word, allowWords)

        q = collections.deque()
        q.append((beginWord, 1))
        visited = set()
        visited.add(beginWord)

        while q: 
            cur, step = q.popleft()
            neighbors = neighborsMap[cur]
            for neighbor in neighbors:
                if neighbor == endWord: 
                    return step + 1
                if neighbor not in visited:
                    visited.add(neighbor)
                    q.append((neighbor, step + 1))
        return 0
```

This solution works but can be further optimized for efficiency:

Word Pattern Dictionary:
Instead of comparing each word pair in getNeighbors, preprocess the word list by generating intermediate patterns. For example:
For hot, generate patterns h*t, ho*, and *ot.
Store these patterns in a dictionary for efficient lookup.
Bidirectional BFS:
Perform BFS from both beginWord and endWord simultaneously to reduce the search space.


```python
from typing import List
import collections

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        if endWord not in wordList:
            return 0
        
        # Preprocessing: Create a dictionary of patterns
        wordList = set(wordList)  # Use a set for faster lookups
        pattern_dict = collections.defaultdict(list)
        
        for word in wordList:
            for i in range(len(word)):
                pattern = word[:i] + "*" + word[i+1:]
                pattern_dict[pattern].append(word)
        
        # Bidirectional BFS Initialization
        begin_set = {beginWord}
        end_set = {endWord}
        visited = set()
        steps = 1
        
        while begin_set and end_set:
            # Always expand the smaller set for efficiency
            if len(begin_set) > len(end_set):
                begin_set, end_set = end_set, begin_set
            
            next_set = set()
            for word in begin_set:
                visited.add(word)
                for i in range(len(word)):
                    pattern = word[:i] + "*" + word[i+1:]
                    for neighbor in pattern_dict[pattern]:
                        if neighbor in end_set:  # If the two searches meet
                            return steps + 1
                        if neighbor not in visited:
                            next_set.add(neighbor)
            
            begin_set = next_set
            steps += 1
        
        return 0
```

```txt
详细解释：Word Pattern Dictionary
在解决单词接龙问题时，找到一个单词的“邻居”是关键问题。邻居定义为只相差一个字符的单词，例如 hot 和 dot 是邻居。然而，直接逐一比较每个单词（像你在 getNeighbors 方法中实现的那样）在单词列表很大的时候效率很低。

为了解决这个问题，我们可以通过 Word Pattern Dictionary 的方法大大优化寻找邻居的过程。

核心思想
单词模式 (Pattern)

将单词中的每个字符依次替换为 *，生成一个单词模式。
单词模式的作用是将一类具有某种相似性的单词归为一组。

示例

对于单词 hot：

第一个字符替换成 *，得到模式 *ot
第二个字符替换成 *，得到模式 h*t
第三个字符替换成 *，得到模式 ho*
如果我们将所有单词的模式都存储在字典中，每个模式对应一组单词，那么找到某个单词的邻居就可以通过这些模式来快速定位。

构建 Word Pattern Dictionary
我们构建一个字典（pattern_dict），字典的键是单词模式，值是所有符合该模式的单词列表。

示例

给定单词列表：["hot", "dot", "dog", "lot", "log", "cog"]

对 hot 生成模式：
*ot -> ["hot"]
h*t -> ["hot"]
ho* -> ["hot"]
对 dot 生成模式：
*ot -> ["hot", "dot"]
d*t -> ["dot"]
do* -> ["dot"]
对 dog 生成模式：
*og -> ["dog"]
d*g -> ["dog"]
do* -> ["dot", "dog"]
以此类推，最终生成的 pattern_dict：

{
    "*ot": ["hot", "dot", "lot"],
    "h*t": ["hot"],
    "ho*": ["hot"],
    "d*t": ["dot"],
    "do*": ["dot", "dog"],
    "*og": ["dog", "log", "cog"],
    "d*g": ["dog"],
    "l*t": ["lot"],
    "lo*": ["lot", "log"],
    "c*g": ["cog"],
    "co*": ["cog"]
}
快速查找邻居
构建 pattern_dict 后，找到一个单词的邻居非常快速。
对于单词 hot：

生成其模式：*ot, h*t, ho*
在 pattern_dict 中查找这些模式对应的单词列表。
*ot -> ["hot", "dot", "lot"]
h*t -> ["hot"]
ho* -> ["hot"]
将这些单词去重后，得到 hot 的邻居：["dot", "lot"]
这比逐一比较每个单词要高效得多。
```
