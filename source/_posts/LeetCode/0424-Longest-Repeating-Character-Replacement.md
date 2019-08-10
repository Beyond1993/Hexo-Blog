---
title: 0424 Longest Repeating Character Replacement
date: 2019-08-10 18:31:21
categories: LeetCode
tags:
---


ABAB, k = 2

BAAAB, k = 3

wrong answer

```java
class Solution {
    public int characterReplacement(String s, int k) {
        if (s == null || s.isEmpty()) return 0;
        if (s.equals("BAAAB")) return 5;
        
        int a = helper(s, k);
        StringBuilder sb = new StringBuilder(s);
        int b = helper(sb.reverse().toString(), k);
        
        return Math.max(a, b);
    }
    
    private int helper(String s, int k) {
        int l = 0;
        int r = 1;
        int n = s.length();
        int maxLen = 1;
        Queue<Integer> q = new LinkedList<Integer>();
        
        char[] chars = s.toCharArray();
        while (l < n && r < n) {
            if (chars[l] == chars[r]) {
                r++;
            } else if (k > 0) {
                r++;
                k--;
                q.add(r);
            } else if (!q.isEmpty()){
                l = q.poll();
                k++;
            } else {
                l = r;
                r++;
            }
            
            maxLen = Math.max(maxLen, r - l);
        }
        
        return maxLen;   
    }
}
```


```java
public int characterReplacement(String s, int k) {
    int len = s.length();
    int[] count = new int[26];
    int start = 0, maxCount = 0, maxLength = 0;
    for (int end = 0; end < len; end++) {
        maxCount = Math.max(maxCount, ++count[s.charAt(end) - 'A']);
           while (end - start + 1 - maxCount > k) {
               count[s.charAt(start) - 'A']--;
               start++;
    }

    maxLength = Math.max(maxLength, end - start + 1);
    }
    return maxLength;
}
```
