---
title: 0139 Word Break
date: 2018-01-09 01:35:12
categories: LeetCode
tags:
---

Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words. You may assume the dictionary does not contain duplicate words.

For example, given
s = "leetcode",
dict = ["leet", "code"].

Return true because "leetcode" can be segmented as "leet code".

UPDATE (2017/1/4):
The wordDict parameter had been changed to a list of strings (instead of a set of strings). Please reload the code definition to get the latest changes.


```java
class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {  
        if (s.length() == 0) {
            return true;
        }
        boolean res = false;
        for (String word: wordDict) {
            if (s.startsWith(word)) {
                res = res || wordBreak(s.substring(word.length()), wordDict);
            }
        }
        return res;
    }
}
```

```java
class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {  
        return wordBreakHelper(s, wordDict, new HashMap<String, Boolean>());       
    }
    private boolean wordBreakHelper(String s, List<String> wordDict, Map<String, Boolean> map) {
        
        if (map.containsKey(s)) {
            return map.get(s);
        }
        
        if (s.length() == 0) {
            return true;
        }
        boolean res = false;
        for (String word: wordDict) {
            if (s.startsWith(word)) {
                res = res || wordBreakHelper(s.substring(word.length()), wordDict, map);
            }
        }
        map.put(s,res);
        return res;

    }
}
```

//动态规划四要素：

// 状态： t[i] true 表示 0 ～ i - 1  是否满足。
// 转义方程： 在 0 ~ i-1, 1 ~ i-1, 2 ~ i-1...... i-1 ~i-1 如果存在 字典里的值， 则为true  
// 初始化： t[0] = true;
// 答案： t[s.length()] 表示 0 ~ i - 1 是否全在字典里。

```java
public class Solution {
    public boolean wordBreak(String s, Set<String> wordDict) {
        int len  = s.length();
        boolean[] t = new boolean[len + 1];
        t[0] = true;
        for(int i = 1; i < len + 1; i++) {
            for (int j = 0; j < i; j++) {
                t[i] = t[j] && wordDict.contains(s.substring(j, i));
                if (t[i]) {
                   // t[i] = true;
                    break;
                }
            }
        }
        
        return t[len];
    }
}
```

```java
class Solution {
    public boolean canCross(int[] stones) {
        Boolean[][] MM = new Boolean[stones.length][stones.length];
        return helper(stones, 0, 0, MM);
    }
    
    public boolean helper(int[] stones, int start, int k, Boolean[][] MM) {
        
        if (MM[k][start] != null) {
            return MM[k][start];
        }
        
        if (start == stones.length - 1) return MM[k][start] = true;
        
        for (int end = start + 1; end < stones.length; ++ end) {
            int step = stones[end] - stones[start];
            if ((step >= k - 1 && step <= k + 1) && helper(stones, end, step, MM)) {
                return MM[step][start] = true;
            }
        }
        
        return MM[k][start] = false;
    }
}
```
