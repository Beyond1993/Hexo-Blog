---
title: 0290 Word Pattern
date: 2018-01-07 21:06:22
categories: LeetCode
tags:
---

Given a pattern and a string str, find if str follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in str.

Examples:
pattern = "abba", str = "dog cat cat dog" should return true.
pattern = "abba", str = "dog cat cat fish" should return false.
pattern = "aaaa", str = "dog cat cat dog" should return false.
pattern = "abba", str = "dog dog dog dog" should return false.
Notes:
You may assume pattern contains only lowercase letters, and str contains lowercase letters separated by a single space.

Credits:
Special thanks to @minglotus6 for adding this problem and creating all test cases.



这题思路很简单，就是一个Map 做映射。


```java
public boolean wordPattern(String pattern, String str) {
    Map<Character, String> map = new HashMap<Character, String>();
    Set<String> set = new HashSet<String>();
    int len1 = pattern.length();
    String[] words = str.split("\\s+");
    int len2 = words.length;

    if (len1 != len2) return false;
    for (int i = 0; i < len1; i++) {
        if (!map.containsKey(pattern.charAt(i))) {
            if (set.contains(words[i])) return false; 
            map.put(pattern.charAt(i), words[i]);
            set.add(words[i]);
        } else {
            if (!map.get(pattern.charAt(i)).equals(words[i])) {

                return false;
            }
        }
    }
    return true;
}
```

