---
title: 0336 Palindrome Pairs
date: 2018-01-06 22:49:49
categories: LeetCode
tags:
---

Given a list of unique words, find all pairs of distinct indices (i, j) in the given list, so that the concatenation of the two words, i.e. words[i] + words[j] is a palindrome.

Example 1:
Given words = ["bat", "tab", "cat"]
Return [[0, 1], [1, 0]]
The palindromes are ["battab", "tabbat"]
Example 2:
Given words = ["abcd", "dcba", "lls", "s", "sssll"]
Return [[0, 1], [1, 0], [3, 2], [2, 4]]
The palindromes are ["dcbaabcd", "abcddcba", "slls", "llssssll"]

这题有意思的地方是这些词都是不规则的。长短不一样，也可以拼接。

所以这题的本质还是一个two sum, value 到 index 的映射,如果一个单词本身就有回文结构了，就判断剩下的部分有没有回文.

```java
public class Solution {
    public List<List<Integer>> palindromePairs(String[] words) {
      List<List<Integer>> ret = new ArrayList<>(); 
      if (words == null || words.length < 2) return ret;
      Map<String, Integer> map = new HashMap<String, Integer>();
      for (int i=0; i<words.length; i++) map.put(words[i], i);
      for (int i=0; i<words.length; i++) {
        for (int j=0; j<=words[i].length(); j++) { 
            String str1 = words[i].substring(0,j);
            String str2 = words[i].substring(j);
            if (isPalindrome(str1)) {
                String str2rvs = new StringBuilder(str2).reverse().toString();
                if (map.containsKey(str2rvs) && map.get(str2rvs) != i) {
                    List<Integer> list = new ArrayList<Integer>();
                    list.add(map.get(str2rvs));
                    list.add(i);
                    ret.add(list);
                }
            }
            if (isPalindrome(str2)) {
                String str1rvs = new StringBuilder(str1).reverse().toString();
                if (map.containsKey(str1rvs) && map.get(str1rvs) != i && str2.length()!=0) { 
                    List<Integer> list = new ArrayList<Integer>();
                    list.add(i);
                    list.add(map.get(str1rvs));
                    ret.add(list);
                    }
                }
            }
        }
        return ret;
    }

    private boolean isPalindrome(String str) {
        int left = 0;
        int right = str.length() - 1;
        while (left <= right) {
            if (str.charAt(left++) !=  str.charAt(right--)) return false;
        }
        return true;
    }
}
```


