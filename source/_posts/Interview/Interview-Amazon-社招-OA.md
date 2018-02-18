---
title: Interview Amazon 社招 OA
date: 2018-02-17 23:15:51
categories: Interview
tags:
---

在window size 为 K 的window, 找k个不同character


```java
public static List<String> kDist(String s, int k) {
    // corner case
    // TODO
    
    int[] map = new int[256];
    int count = 0;
    Set<String> res = new HashSet<>();
    
    // init k
    for (int i = 0; i < k; ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
    }
    if (count == k) {
      res.add(s.substring(0, k));
    } 
    
    for (int i = k; i < s.length(); ++ i) {
      if (map[s.charAt(i)] ++ == 0) {
        ++ count;
      }
      if (map[s.charAt(i - k)]-- == 1) {
        -- count;
      }
      if (count == k) {
        res.add(s.substring(i - k + 1, i + 1));
      }
    }
    return new ArrayList<String>(res);
  }
```
