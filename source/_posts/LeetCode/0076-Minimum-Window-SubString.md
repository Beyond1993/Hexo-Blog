---
title: 0076 Minimum Window SubString
date: 2018-02-17 22:48:03
categories: LeetCode
tags:
---

Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

For example,
S = "ADOBECODEBANC"
T = "ABC"
Minimum window is "BANC".

Note:
If there is no such window in S that covers all characters in T, return the empty string "".

If there are multiple such windows, you are guaranteed that there will always be only one unique minimum 


这题很经典，写代码的时候需要注意两点

1. 先确定 end 指针，再移动 begain
2. count 只能再 &lt;char, count&gt; 在0～1 边界变化的时候，才改变值.  

```java
class Solution {
    public String minWindow(String s, String t) {
        Map<Character, Integer> map = new HashMap<Character, Integer>();
        for (int i = 0; i < t.length(); i++) {
            map.put(t.charAt(i), map.getOrDefault(t.charAt(i), 0) + 1);
        }
        int begain = 0;
        int end = 0;
        int count = map.size();
        int len = Integer.MAX_VALUE;
        String result = "";
        while(begain < s.length() && end < s.length()) {
          while(count > 0  && end < s.length()) {   
              if (map.containsKey(s.charAt(end)) ) {
                  int num = map.get(s.charAt(end));
                  map.put(s.charAt(end),  --num );
                  if (num == 0) {
                     count--;
                  }
              } 
              end++;
          }
          
          while(count == 0) {
              if (map.containsKey(s.charAt(begain) ) ) {
                int num = map.get(s.charAt(begain));
                map.put(s.charAt(begain), ++ num);
                if (num == 1) {
                  count++;
                }
                int curLen = end + 1 - begain;
                if (curLen < len) {
                    len = curLen;
                    result = s.substring(begain, end);  
                }
              }
              begain++;
          }
        }
        return result;
    }
}
```
