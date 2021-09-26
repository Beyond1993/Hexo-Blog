---
title: 0471 Encode String with Shortest Length
date: 2021-09-27 02:35:43
categories:
tags:
---

DFS Mem search

```java
class Solution {
    public String encode(String s) {
        return helper(s, new HashMap<>());
    }
    
    public String helper(String s, Map<String, String> map) {
        if (s == null || s.length() < 5) {
            return s;
        }
        if (map.containsKey(s)) {
            return map.get(s);
        }
        int n = s.length();
        String minEncoded = s;
        for (int i = n / 2; i < n; i++) {
            String pattern = s.substring(i);
            if (n % pattern.length() != 0) {
                continue;
            }
            int repeats = countRepeats(s, pattern);
            if (repeats * pattern.length() != s.length()) {
                continue;
            }
            String encoded = repeats + "[" + helper(pattern, map) + "]";
            if (encoded.length() < minEncoded.length()) {
                minEncoded = encoded;
            }
        }
        for (int i = 1; i < n; i++) {
            String encodedLeft = helper(s.substring(0, i), map);
            String encodedRight = helper(s.substring(i), map);
            String encoded = encodedLeft + encodedRight;
            if (encoded.length() < minEncoded.length()) {
                minEncoded = encoded;
            }
        }
        map.put(s, minEncoded);
        return minEncoded;
    }
    
    private int countRepeats(String s, String pattern) {
        int repeats = 0;
        int i = 0;
        while (i < s.length()) {
            if (s.indexOf(pattern, i) >= 0) {
                repeats++;
                i = s.indexOf(pattern, i) + pattern.length();
            } else {
                break;
            }
        }
        return repeats;
    }
}
```
