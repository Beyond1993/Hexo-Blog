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
