---
title: 0472 Concatenated Words
date: 2020-06-07 22:31:25
categories: LeetCode
tags:
---

Given a list of words (without duplicates), please write a program that returns all concatenated words in the given list of words.
A concatenated word is defined as a string that is comprised entirely of at least two shorter words in the given array.

Example:
Input: ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]

Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]

Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats"; 
 "dogcatsdog" can be concatenated by "dog", "cats" and "dog"; 
"ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".

这题非常有意思。给一个个字符串数组，判断是否是组合字符串.

组合字符串含义是 至少由数组中两个字符串组成。

### 解法1: 暴力解

对于每一个字符，尝试匹配开头，一旦匹配成功就取substring, 进到下一层匹配.

#### 纯暴力
```java
class Solution {
    public List<String> findAllConcatenatedWordsInADict(String[] words) {
        List<String> ans = new ArrayList<>();
        HashSet<String> wordSet = new HashSet<>(Arrays.asList(words));
        for (String word : words) if (dfs(word, wordSet)) ans.add(word);
        return ans;
    }
    boolean dfs(String word, HashSet<String> wordSet) {
        for (int i = 1; i < word.length(); i++) {
            if (wordSet.contains(word.substring(0, i))) {
                String suffix = word.substring(i);
                if (wordSet.contains(suffix) || dfs(suffix, wordSet)) {   
                    return true;
                }
            }
        }
        
        return false;
    }
}
```
#### 加 cache


```java
class Solution {
    public List<String> findAllConcatenatedWordsInADict(String[] words) {
        List<String> ans = new ArrayList<>();
        HashSet<String> wordSet = new HashSet<>(Arrays.asList(words));
        HashMap<String, Boolean> cache = new HashMap<>();
        for (String word : words) if (dfs(word, wordSet, cache)) ans.add(word);
        return ans;
    }
    boolean dfs(String word, HashSet<String> wordSet, HashMap<String, Boolean> cache) {
        if (cache.containsKey(word)) return cache.get(word);
        for (int i = 1; i < word.length(); i++) {
            if (wordSet.contains(word.substring(0, i))) {
                String suffix = word.substring(i);
                if (wordSet.contains(suffix) || dfs(suffix, wordSet, cache)) {
                    cache.put(word, true);
                    return true;
                }
            }
        }
        cache.put(word, false);
        return false;
    }
}
```

### 解法2: 用trie tree， 构建前缀树
本质上也是暴力解

```java
class Solution {
    private static Node root;
    
    public List<String> findAllConcatenatedWordsInADict(String[] words) {
        if (words == null || words.length == 0)
            return new ArrayList<>();
        
        root = new Node();
        buildTrie(words);
        
        List<String> result = new LinkedList<>();
        for (String word : words) {
            if (isConcatenated(word, 0, 0))
                result.add(word);
        }
        return result;
    }
    
    // Return true if word starting from index is concatenated
    boolean isConcatenated(String word, int index, int countConcatenatedWords) {
        if (index == word.length())
            return countConcatenatedWords >= 2;
        
        Node ptr = root;
        for (int i = index; i < word.length(); i++) {
            if (ptr.children[word.charAt(i) - 'a'] == null) 
                return false;
            ptr = ptr.children[word.charAt(i) - 'a'];
            
            if (ptr.isWordEnd)
                if (isConcatenated(word, i + 1, countConcatenatedWords + 1))
                    return true;
        }
        
        return false;
    }
    
    private void buildTrie(String[] words) {
        Node ptr;
        for (String word : words) {
            ptr = root;
            for (char ch : word.toCharArray()) {
                int order = ch - 'a';
                if (ptr.children[order] == null) {
                    ptr.children[order] = new Node();
                } 
                ptr = ptr.children[order];
            }
            ptr.isWordEnd = true;
        }
    }
    
    class Node {
        Node[] children;
        boolean isWordEnd;
        
        public Node() {
            children = new Node[26];
            isWordEnd = false;
        }
    }
}
```

### 解法3: DP

类似于 word break

同样明显的是，一个单词只能由比它短的单词组成。因此，我们可以先按每个单词的长度对输入进行排序，然后仅尝试使用前面的单词来组成一个单词。

```java
public class Solution {
    public static List<String> findAllConcatenatedWordsInADict(String[] words) {
        List<String> result = new ArrayList<>();
        Set<String> preWords = new HashSet<>();
        Arrays.sort(words, new Comparator<String>() {
            public int compare (String s1, String s2) {
                return s1.length() - s2.length();
            }
        });
        
        for (int i = 0; i < words.length; i++) {
            if (canForm(words[i], preWords)) {
                result.add(words[i]);
            }
            preWords.add(words[i]);
        }
        
        return result;
    }
    
    private static boolean canForm(String word, Set<String> dict) {
        if (dict.isEmpty()) return false;
    boolean[] dp = new boolean[word.length() + 1];
    dp[0] = true;
    for (int i = 1; i <= word.length(); i++) {
        for (int j = 0; j < i; j++) {
        if (!dp[j]) continue;
        if (dict.contains(word.substring(j, i))) {
            dp[i] = true;
            break;
        }
        }
    }
    return dp[word.length()];
    }
}
```
