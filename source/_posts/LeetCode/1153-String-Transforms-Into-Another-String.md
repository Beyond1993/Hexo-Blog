---
title: 1153 String Transforms Into Another String
date: 2021-01-17 06:16:27
categories:
tags:
---





```java
class Solution {
    public boolean canConvert(String str1, String str2) {
        
        if (str1.equals(str2)) return true;
        
        if (str1.length() != str2.length()) {
            return false;
        }
        
        Map<Character, Character> map = new HashMap<>();
        
        for (int i = 0; i < str2.length(); i++) {
            if (map.containsKey(str1.charAt(i))) {
                if (map.get(str1.charAt(i)) != str2.charAt(i)) {
                    return false;
                }
            } else {
                map.put(str1.charAt(i), str2.charAt(i));
            }
        }
        
        return new HashSet<Character>(map.values()).size() < 26;
    }
}
```
