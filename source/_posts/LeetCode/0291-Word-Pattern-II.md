---
title: 0291 Word Pattern II
date: 2018-01-07 21:09:44
categories: LeetCode
tags:
---

Given a pattern and a string str, find if str follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty substring in str.

Examples:
pattern = "abab", str = "redblueredblue" should return true.
pattern = "aaaa", str = "asdasdasdasd" should return true.
pattern = "aabb", str = "xyzabcxzyabc" should return false.
Notes:
You may assume both pattern and str contains only lowercase letters.


这里的暴力解，

```java
public class Solution {
    Map<Character, String> map = new HashMap<Character, String>();
    
    Set<String> set = new HashSet<String>();
    
    public boolean wordPatternMatch(String pattern, String str) {
        
        if (pattern.isEmpty()) return str.isEmpty();
        
        if (map.containsKey(pattern.charAt(0))) {
            
            String val = map.get(pattern.charAt(0));
            
            if (!str.startsWith(val)) return false;
            
            if (wordPatternMatch(pattern.substring(1), str.substring(val.length()))) return true;
            
        } else {
            for (int i = 1; i <= str.length(); i++) {
                
                if (set.contains(str.substring(0,i))) continue;
                
                map.put(pattern.charAt(0), str.substring(0,i));
                
                set.add(str.substring(0,i));
                
                if (wordPatternMatch(pattern.substring(1), str.substring(i))) return true;
                
                map.remove(pattern.charAt(0));
                
                set.remove(str.substring(0,i));
            }
        }
        return false;
    }
}
```

但是因为他是Java, 加上剪枝，可能不会很慢
