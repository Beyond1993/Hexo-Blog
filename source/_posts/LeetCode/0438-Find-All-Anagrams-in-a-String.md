---
title: 0438 Find All Anagrams in a String
date: 2018-02-17 22:50:24
categories: LeetCode
tags:
---

Given a string s and a non-empty string p, find all the start indices of p's anagrams in s.

Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.

The order of output does not matter.

Example 1:

Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
Example 2:

Input:
s: "abab" p: "ab"

Output:
[0, 1, 2]

Explanation:
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".

```java
class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        Map<Character, Integer> map = new HashMap<Character, Integer>();
        int len = p.length();
        for (int i = 0; i < len; i++) {
            map.put(p.charAt(i), map.getOrDefault(p.charAt(i), 0) + 1);
        }
        int begain = 0;
        int end = 0;
        int count = map.size();
        int len = 0;
        List<Integer> result = new ArrayList<Integer>();
        
        while(begain < s.length() && end < s.length()) {
            while(count > 0 && end < s.length()) {
                if (map.containsKey(s.charAt(end))) {
                    int num = map.get(s.charAt(end));
                    map.put(s.charAt(end), --num);
                    if (num == 0) {
                        count--;
                    }
                }
                end++;
            }
            
            while(count == 0) {
                if (map.containsKey(s.charAt(begain))) {
                  int num = map.get(s.charAt(begain));
                  map.put(s.charAt(begain), ++num);
                  if (num == 1) {
                      count++;
                  }
                  if (end - begain == len) {
                     result.add(begain);
                  }
                }
                begain ++;
            }
        }
        
        return result;
    }
}
```


