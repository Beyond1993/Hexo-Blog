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

但是因为他是Java, 加上剪枝，可能不会很慢。 这种解法的时间复杂度是多少？这就可以衍生到一般 backtrace 的时间复杂度


这题的Map 是建立一个字符 和 一个 word 之间的mapping

那这个set 又是用来干嘛的?

我们考虑 pattern : 'aba', str : 'aaa'

如果不用set,  就变成 a --> a,  b --> a, 但是我们知道这是一一对应的关系，所以 b --> aa, 这才对，所以已经在Map&t;Character, String&gt; 的 String 里出现的值，我们直接跳过. 

下面这个链接说 f(n) = n*(n-1)*...*1 = n^n

https://www.programcreek.com/2014/07/leetcode-word-pattern-ii-java/
