---
title: 0049 Group Anagrams
date: 2019-10-18 00:36:06
categories: LeetCode
tags:
---

```java
class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String,List<String>> map = new HashMap<>();
  for (String s: strs) {
    char[] c = s.toCharArray();
    Arrays.sort(c);
    String val = String.valueOf(c);
    if (map.containsKey(val)) {
      List<String> list = map.get(val);
      list.add(s);
        //map.put(val,list);
    } else {
      List<String> temp = new ArrayList<>();
      temp.add(s);
      map.put(val,temp);
    }
  } 
  List<List<String>> res = new ArrayList<>();
  for (List<String> l:map.values()) {
    res.add(l);
  } 
  return res; 
    }
}
```
